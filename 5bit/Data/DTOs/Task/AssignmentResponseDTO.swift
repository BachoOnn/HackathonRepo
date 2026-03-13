//
//  AssignmentResponseDTO.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

struct AssignmentResponseDTO: Codable {
    let id: Int
    let taskId: Int
    let taskTitle: String?
    let coinReward: Int
    let childId: Int
    let childName: String?
    let status: String?
    let isRewardGranted: Bool
    let createdAt: String
    let completedAt: String?
    let approvedAt: String?
}

extension AssignmentResponseDTO {
    func toDomain() -> Assignment {
        let status = AssignmentStatus(raw: self.status)
        return Assignment(
            id: id,
            taskId: taskId,
            taskTitle: taskTitle ?? "Task",
            taskDescription: nil,  
            coinReward: coinReward,
            childId: childId,
            childName: childName ?? "",
            status: isRewardGranted ? .unknown : status,
            isRewardGranted: isRewardGranted
        )
    }
}
