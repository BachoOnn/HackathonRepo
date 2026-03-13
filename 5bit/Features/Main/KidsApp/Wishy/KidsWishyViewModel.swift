//
//  KidsWishyViewModel.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import Combine
import Foundation

@MainActor
final class KidsWishyViewModel: ObservableObject {
    
    // MARK: - Published
    @Published var activeMissions: [Assignment] = []
    @Published var completedMissions: [Assignment] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    // MARK: - Dependencies
    private weak var coordinator: AppCoordinator?
    private let getKidDataUseCase: GetKidDataUseCase
    private let acceptTaskUseCase: AcceptTaskUseCase
    private let completeTaskUseCase: CompleteTaskUseCase
    
    init(
        coordinator: AppCoordinator,
        getKidDataUseCase: GetKidDataUseCase,
        acceptTaskUseCase: AcceptTaskUseCase,
        completeTaskUseCase: CompleteTaskUseCase
    ) {
        self.coordinator = coordinator
        self.getKidDataUseCase = getKidDataUseCase
        self.acceptTaskUseCase = acceptTaskUseCase
        self.completeTaskUseCase = completeTaskUseCase
    }
    
    var childId: Int { coordinator?.currentUser?.userId ?? 0 }
    
    func onLoad() {
        Task { await fetchAssignments() }
    }
    
    func acceptTask(_ assignment: Assignment) {
        Task { await performAccept(assignment) }
    }
    
    func completeTask(_ assignment: Assignment) {
        Task { await performComplete(assignment) }
    }
}

fileprivate extension KidsWishyViewModel {
    
    func fetchAssignments() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let parentId = coordinator?.currentUser?.parentId
            let (assignments, _, _) = try await getKidDataUseCase.execute(
                childId: childId,
                parentId: parentId
            )
            activeMissions = assignments.filter { !$0.isRewardGranted }
            completedMissions = assignments.filter { $0.isRewardGranted }
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func performAccept(_ assignment: Assignment) async {
        do {
            try await acceptTaskUseCase.execute(assignmentId: assignment.id, childId: childId)
            await fetchAssignments()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func performComplete(_ assignment: Assignment) async {
        do {
            try await completeTaskUseCase.execute(assignmentId: assignment.id, childId: childId)
            await fetchAssignments()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
