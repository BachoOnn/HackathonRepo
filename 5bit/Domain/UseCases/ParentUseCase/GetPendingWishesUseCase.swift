//
//  GetPendingWishesUseCase.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

protocol GetPendingWishesUseCase {
    func execute(parentId: Int) async throws -> [Wish]
}

struct DefaultGetPendingWishesUseCase: GetPendingWishesUseCase {
    private let taskRepository: TaskRepositoryProtocol
    init(taskRepository: TaskRepositoryProtocol) { self.taskRepository = taskRepository }
    func execute(parentId: Int) async throws -> [Wish] {
        try await taskRepository.getPendingWishes(parentId: parentId)
    }
}
