//
//  KidsHomeViewModel.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import Combine
import Foundation

@MainActor
final class KidsHomeViewModel: ObservableObject {
    
    @Published var balance: KidBalance = KidBalance(coins: 0, money: 0)
    @Published var recentTransactions: [Transaction] = []
    @Published var activeMissionCount: Int = 0
    @Published var totalActiveReward: Int = 0
    @Published var earnedCoins: Int = 0
    @Published var isLoading: Bool = false
    @Published var isConverting: Bool = false
    @Published var errorMessage: String? = nil
    @Published var convertAmount: String = ""
    @Published var showConvertSheet: Bool = false
    
    var xp: Int { XPHelper.xp(from: earnedCoins) }
    var level: Int { XPHelper.level(from: xp) }
    var xpProgress: Double { XPHelper.xpProgress(xp: xp) }
    var xpInLevel: Int { XPHelper.xpInCurrentLevel(xp: xp) }
    var xpForNextLevel: Int { XPHelper.xpForNextLevel(currentLevel: level) }
    var parentId: Int? { coordinator?.currentUser?.parentId }
    
    var convertAmountInt: Int { Int(convertAmount) ?? 0 }
    var isConvertValid: Bool {
        convertAmountInt > 0 &&
        convertAmountInt <= balance.coins &&
        convertAmountInt % 10 == 0
    }
    var gelPreview: Double { Double(convertAmountInt) / 10.0 }
    
    private weak var coordinator: AppCoordinator?
    private let getKidDataUseCase: GetKidDataUseCase
    private let convertCoinsUseCase: ConvertCoinsUseCase
    
    init(
        coordinator: AppCoordinator,
        getKidDataUseCase: GetKidDataUseCase,
        convertCoinsUseCase: ConvertCoinsUseCase
    ) {
        self.coordinator = coordinator
        self.getKidDataUseCase = getKidDataUseCase
        self.convertCoinsUseCase = convertCoinsUseCase
    }
    
    var childId: Int { coordinator?.currentUser?.userId ?? 0 }
    var childName: String { coordinator?.currentUser?.name ?? "Kid" }
    
    func onLoad() {
        Task { await fetchData() }
    }
    
    func navigateToWishy() {
        coordinator?.push(.kidsWishy)
    }
    
    func convert() {
        Task { await performConvert() }
    }
}

fileprivate extension KidsHomeViewModel {
    
    func fetchData() async {
        isLoading = true
        errorMessage = nil
        do {
            let (assignments, balance, history) = try await getKidDataUseCase.execute(
                childId: childId, parentId: parentId
            )
            self.balance = balance
            self.recentTransactions = Array(history.prefix(3))
            let active = assignments.filter { !$0.isRewardGranted }
            self.activeMissionCount = active.count
            self.totalActiveReward = active.reduce(0) { $0 + $1.coinReward }
            self.earnedCoins = balance.coins
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func performConvert() async {
        guard isConvertValid else { return }
        isConverting = true
        do {
            let newBalance = try await convertCoinsUseCase.execute(
                childId: childId, amount: convertAmountInt
            )
            balance = newBalance
            earnedCoins = newBalance.coins
            convertAmount = ""
            showConvertSheet = false
        } catch {
            errorMessage = error.localizedDescription
        }
        isConverting = false
    }
    
}
