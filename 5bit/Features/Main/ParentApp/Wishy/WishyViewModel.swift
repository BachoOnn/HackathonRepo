//
//  WishyViewModel.swift
//  5bit
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
    
    weak var coordinator: AppCoordinator?
    private let getAssignmentsUseCase: GetParentAssignmentsUseCase
    private let getBalanceUseCase: GetChildBalanceUseCase
    private let approveTaskUseCase: ApproveTaskUseCase
    
    init(
        coordinator: AppCoordinator,
        getParentAssignmentsUseCase: GetParentAssignmentsUseCase,
        getBalanceUseCase: GetChildBalanceUseCase,
        approveTaskUseCase: ApproveTaskUseCase
    ) {
        self.coordinator = coordinator
        self.getAssignmentsUseCase = getParentAssignmentsUseCase
        self.getBalanceUseCase = getBalanceUseCase
        self.approveTaskUseCase = approveTaskUseCase
    }
    
    var filteredAssignments: [Assignment] {
        assignments.filter {
            $0.childId == selectedKid.apiId &&
            effectiveTab($0) == selectedTab
        }
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
        if let first = derived.first { selectedKid = first }
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
        case 3: return "👦🏻"
        case 4: return "🧒"
        default: return "🧒"
        }
    }
}
