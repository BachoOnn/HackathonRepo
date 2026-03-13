//
//  AcceptTaskUseCase.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//


protocol AcceptTaskUseCase {
    func execute(assignmentId: Int, childId: Int) async throws
}

struct DefaultAcceptTaskUseCase: AcceptTaskUseCase {
    private let kidRepository: KidRepositoryProtocol

    init(kidRepository: KidRepositoryProtocol) {
        self.kidRepository = kidRepository
    }

    func execute(assignmentId: Int, childId: Int) async throws {
        _ = try await kidRepository.acceptTask(assignmentId: assignmentId, childId: childId)
    }
}
