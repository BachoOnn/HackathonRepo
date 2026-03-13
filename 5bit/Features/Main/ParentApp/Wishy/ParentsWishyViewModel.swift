//
//  WishyViewModel.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import Combine
import Foundation

@MainActor
final class ParentWishyViewModel: ObservableObject {
    
    @Published var selectedTab: WishyTab = .progress
    @Published var selectedKid: KidProfile = KidProfile.mock[0]
    @Published var kids: [KidProfile] = []
    @Published var assignments: [Assignment] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var pendingWishes: [Wish] = []
    @Published var selectedWish: Wish? = nil
    @Published var showSetPriceSheet: Bool = false
    @Published var wishPriceInput: String = ""
    
    weak var coordinator: AppCoordinator?
    private let getAssignmentsUseCase: GetParentAssignmentsUseCase
    private let getBalanceUseCase: GetChildBalanceUseCase
    private let approveTaskUseCase: ApproveTaskUseCase
    private let getPendingWishesUseCase: GetPendingWishesUseCase
    private let setWishPriceUseCase: SetWishPriceUseCase
    private let getKidWishesUseCase: GetKidWishesUseCase
    
    init(
        coordinator: AppCoordinator,
        getParentAssignmentsUseCase: GetParentAssignmentsUseCase,
        getBalanceUseCase: GetChildBalanceUseCase,
        approveTaskUseCase: ApproveTaskUseCase,
        getPendingWishesUseCase: GetPendingWishesUseCase,
        setWishPriceUseCase: SetWishPriceUseCase,
        getKidWishesUseCase: GetKidWishesUseCase
    ) {
        self.coordinator = coordinator
        self.getAssignmentsUseCase = getParentAssignmentsUseCase
        self.getBalanceUseCase = getBalanceUseCase
        self.approveTaskUseCase = approveTaskUseCase
        self.getPendingWishesUseCase = getPendingWishesUseCase
        self.setWishPriceUseCase = setWishPriceUseCase
        self.getKidWishesUseCase = getKidWishesUseCase
    }
    
    func openSetPriceForAssignment(_ assignment: Assignment) {
        Task {
            print("🔍 looking for wish — title: '\(assignment.taskTitle)', childId: \(assignment.childId)")
            print("🔍 pendingWishes: \(pendingWishes.map { "\($0.id):\($0.title)" })")
            
            if let match = pendingWishes.first(where: { $0.title == assignment.taskTitle }) {
                print("✅ matched from pendingWishes — wishId: \(match.id)")
                openSetPrice(for: match)
                return
            }
            if let wishes = try? await getKidWishesUseCase.execute(childId: assignment.childId),
               let match = wishes.first(where: {
                   $0.title == assignment.taskTitle && $0.status == .pendingPrice  // ← add status check
               }) {
                print("✅ matched from kidWishes — wishId: \(match.id)")
                openSetPrice(for: match)
            } else {
                print("❌ no match found or wish already priced")
            }
        }
    }
    
    var filteredAssignments: [Assignment] {
        assignments.filter {
            $0.childId == selectedKid.apiId &&
            effectiveTab($0) == selectedTab
        }
    }
    var wishPriceInt: Int { Int(wishPriceInput) ?? 0 }
    var isWishPriceValid: Bool { wishPriceInt > 0 }
    
    func openSetPrice(for wish: Wish) {
        selectedWish = wish
        wishPriceInput = ""
        showSetPriceSheet = true
    }
    
    func submitWishPrice() {
        Task { await performSetPrice() }
    }
    
    func taskCount(for tab: WishyTab) -> Int {
        assignments.filter {
            $0.childId == selectedKid.apiId &&
            effectiveTab($0) == tab
        }.count
    }
    
    func selectKid(_ kid: KidProfile) {
        selectedKid = kid
        selectedTab = .progress
    }
    
    func navigateBack() { coordinator?.pop() }
    
    func onLoad() {
        Task { await fetchAssignments() }
    }
    
    func approveTask(_ assignment: Assignment) {
        Task { await performApprove(assignment) }
    }
}

fileprivate extension ParentWishyViewModel {
    
    func effectiveTab(_ assignment: Assignment) -> WishyTab {
        assignment.isRewardGranted ? .done : assignment.status.wishyTab
    }
    
    func fetchAssignments() async {
        guard let parentId = coordinator?.currentUser?.userId else { return }
        isLoading = true
        errorMessage = nil
        do {
            let result = try await getAssignmentsUseCase.execute(parentId: parentId)
            assignments = result
            await buildKids(from: result)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        pendingWishes = (try? await getPendingWishesUseCase.execute(parentId: parentId)) ?? []
        
        isLoading = false
    }
    
    func performApprove(_ assignment: Assignment) async {
        guard let parentId = coordinator?.currentUser?.userId else { return }
        do {
            try await approveTaskUseCase.execute(assignmentId: assignment.id, parentId: parentId)
            await fetchAssignments()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func buildKids(from assignments: [Assignment]) async {
        var seen = Set<Int>()
        var derived: [KidProfile] = []
        let uniqueChildIds = assignments.map { $0.childId }.filter { seen.insert($0).inserted }
        
        for childId in uniqueChildIds {
            let childAssignments = assignments.filter { $0.childId == childId }
            let balance = (try? await getBalanceUseCase.execute(childId: childId)) ?? 0
            let completed = childAssignments.filter { $0.isRewardGranted }.count
            let total = childAssignments.count
            
            derived.append(KidProfile(
                apiId: childId,
                emoji: kidEmoji(for: childId),
                name: fallbackName(for: childId),
                balance: balance,
                completedTasks: completed,
                totalTasks: total,
                progress: total > 0 ? Double(completed) / Double(total) : 0
            ))
        }
        
        kids = derived
        
        if let currentlySelected = derived.first(where: { $0.apiId == selectedKid.apiId }) {
            selectedKid = currentlySelected
        } else if let first = derived.first {
            selectedKid = first
        }
    }
    
    func fallbackName(for id: Int) -> String {
        switch id {
        case 2: return "Alice"
        case 3: return "Bob"
        case 4: return "Charlie"
        default: return "Kid"
        }
    }
    
    func kidEmoji(for id: Int) -> String {
        switch id {
        case 2: return "👧🏼"
        case 3: return "🧒🏽"
        case 4: return "👦🏻"
        default: return "🧒"
        }
    }
    
    func performSetPrice() async {
        guard let wish = selectedWish,
              let parentId = coordinator?.currentUser?.userId,
              isWishPriceValid else {
            print("❌ guard failed — wish: \(selectedWish?.id ?? -1), parentId: \(coordinator?.currentUser?.userId ?? -1), valid: \(isWishPriceValid)")
            return
        }
        print("✅ submitting — wishId: \(wish.id), coinPrice: \(wishPriceInt), parentId: \(parentId)")
        do {
            try await setWishPriceUseCase.execute(
                wishId: wish.id,
                coinPrice: wishPriceInt,
                parentId: parentId
            )
            showSetPriceSheet = false
            selectedWish = nil
            await fetchAssignments()
        } catch {
            print("❌ setWishPrice failed: \(error)")
            errorMessage = error.localizedDescription
        }
    }
}
