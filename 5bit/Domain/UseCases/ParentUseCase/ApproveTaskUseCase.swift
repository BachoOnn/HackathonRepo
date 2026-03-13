//
//  ApproveTaskUseCase.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

protocol ApproveTaskUseCase {
    func execute(assignmentId: Int, parentId: Int) async throws
}

struct DefaultApproveTaskUseCase: ApproveTaskUseCase {
    private let taskRepository: TaskRepositoryProtocol

    init(taskRepository: TaskRepositoryProtocol) {
        self.taskRepository = taskRepository
    }

    func execute(assignmentId: Int, parentId: Int) async throws {
        struct ApproveRequest: Codable { let assignmentId: Int; let parentId: Int }
        let _: AssignmentResponseDTO = try await taskRepository.approveTask(
            assignmentId: assignmentId, parentId: parentId
        )
    }
}
