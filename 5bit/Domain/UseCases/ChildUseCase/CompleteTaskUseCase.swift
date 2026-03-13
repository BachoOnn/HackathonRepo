//
//  CompleteTaskUseCase.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//


protocol CompleteTaskUseCase {
    func execute(assignmentId: Int, childId: Int) async throws
}

struct DefaultCompleteTaskUseCase: CompleteTaskUseCase {
    private let kidRepository: KidRepositoryProtocol

    init(kidRepository: KidRepositoryProtocol) {
        self.kidRepository = kidRepository
    }

    func execute(assignmentId: Int, childId: Int) async throws {
        _ = try await kidRepository.completeTask(assignmentId: assignmentId, childId: childId)
    }
}