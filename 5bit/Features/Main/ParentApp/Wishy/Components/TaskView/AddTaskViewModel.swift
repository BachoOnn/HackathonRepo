//
//  AddTaskViewModel.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import Combine
import Foundation

@MainActor
final class AddTaskViewModel: ObservableObject {
    
    // MARK: - Published
    @Published var selectedTemplate: TaskTemplate? = nil
    @Published var rewardInput: String = "10"
    @Published var description: String = ""
    @Published var selectedKid: KidProfile? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var didSubmitSuccessfully: Bool = false
    
    // MARK: - Props
    let kids: [KidProfile]
    static let quickRewards = [5, 10, 15, 20]
    
    var reward: Int { Int(rewardInput) ?? 0 }
    var isValid: Bool { selectedTemplate != nil && reward > 0 && selectedKid != nil }
    
    // MARK: - Dependencies
    private let parentId: Int
    private let createAndAssignUseCase: CreateAndAssignTaskUseCase
    
    // MARK: - Init
    init(parentId: Int, kids: [KidProfile], createAndAssignUseCase: CreateAndAssignTaskUseCase) {
        self.parentId = parentId
        self.kids = kids
        self.createAndAssignUseCase = createAndAssignUseCase
        self.selectedKid = kids.first
    }
    
    // MARK: - Public
    func applyQuickReward(_ amount: Int) {
        rewardInput = "\(amount)"
    }
    
    func submit() {
        Task { await performSubmit() }
    }
}

fileprivate extension AddTaskViewModel {
    
    func performSubmit() async {
        guard let template = selectedTemplate,
              let kid = selectedKid else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            try await createAndAssignUseCase.execute(
                parentId: parentId,
                title: template.title,
                description: description.isEmpty ? nil : description,
                type: template.type,
                coinReward: reward,
                childId: kid.apiId
            )
            didSubmitSuccessfully = true
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
