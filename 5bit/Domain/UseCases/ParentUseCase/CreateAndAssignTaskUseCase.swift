//
//  CreateAndAssignTaskUseCase.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

protocol CreateAndAssignTaskUseCase {
    func execute(parentId: Int, title: String, description: String?, type: String?, coinReward: Int, childId: Int) async throws
}

struct DefaultCreateAndAssignTaskUseCase: CreateAndAssignTaskUseCase {
    private let taskRepository: TaskRepositoryProtocol

    init(taskRepository: TaskRepositoryProtocol) {
        self.taskRepository = taskRepository
    }

    func execute(parentId: Int, title: String, description: String?, type: String?, coinReward: Int, childId: Int) async throws {
        let taskId = try await taskRepository.createTask(
            parentId: parentId,
            title: title,
            description: description,
            type: type,
            coinReward: coinReward
        )
        try await taskRepository.assignTask(taskId: taskId, childId: childId)
    }
}
