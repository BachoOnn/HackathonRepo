//
//  AddTaskViewModel.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import Combine

final class AddTaskViewModel: ObservableObject {
    @Published var selectedTemplate: TaskTemplate? = nil
    @Published var rewardInput: String = "10"
    @Published var description: String = ""
    
    static let quickRewards = [5, 10, 15, 20]
    
    var reward: Int {
        Int(rewardInput) ?? 0
    }
    
    var isValid: Bool {
        selectedTemplate != nil && reward > 0
    }
    
    func applyQuickReward(_ amount: Int) {
        rewardInput = "\(amount)"
    }
    
    func submit() {
        print("Task: \(selectedTemplate?.title ?? "") | Reward: \(reward) | Desc: \(description)")
    }
}
