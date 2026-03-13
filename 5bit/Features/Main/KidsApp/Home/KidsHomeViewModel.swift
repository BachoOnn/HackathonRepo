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
    @Published var errorMessage: String? = nil
    
    var xp: Int { XPHelper.xp(from: earnedCoins) }
    var level: Int { XPHelper.level(from: xp) }
    var xpProgress: Double { XPHelper.xpProgress(xp: xp) }
    var xpInLevel: Int { XPHelper.xpInCurrentLevel(xp: xp) }
    var xpForNextLevel: Int { XPHelper.xpForNextLevel(currentLevel: level) }
    var parentId: Int? { coordinator?.currentUser?.parentId }
    
    private weak var coordinator: AppCoordinator?
    private let getKidDataUseCase: GetKidDataUseCase
    
    init(coordinator: AppCoordinator, getKidDataUseCase: GetKidDataUseCase) {
        self.coordinator = coordinator
        self.getKidDataUseCase = getKidDataUseCase
    }
    
    var childId: Int { coordinator?.currentUser?.userId ?? 0 }
    var childName: String { coordinator?.currentUser?.name ?? "Kid" }
    
    func onLoad() {
        Task { await fetchData() }
    }
    
    func navigateToWishy() {
        coordinator?.push(.kidsWishy)
    }
}

fileprivate extension KidsHomeViewModel {
    
    func fetchData() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let (assignments, balance, history) = try await getKidDataUseCase.execute(
                childId: childId,
                parentId: parentId
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
}

