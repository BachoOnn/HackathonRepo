//
//  GetChildBalanceUseCase.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

protocol GetChildBalanceUseCase {
    func execute(childId: Int) async throws -> Int
}

struct DefaultGetChildBalanceUseCase: GetChildBalanceUseCase {
    private let taskRepository: TaskRepositoryProtocol

    init(taskRepository: TaskRepositoryProtocol) {
        self.taskRepository = taskRepository
    }

    func execute(childId: Int) async throws -> Int {
        try await taskRepository.getChildBalance(childId: childId)
    }
}
