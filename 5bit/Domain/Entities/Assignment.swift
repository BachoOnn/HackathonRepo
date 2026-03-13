//
//  Assignment.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

struct Assignment: Identifiable {
    let id: Int
    let taskId: Int
    let taskTitle: String
    let taskDescription: String? 
    let coinReward: Int
    let childId: Int
    let childName: String
    let status: AssignmentStatus
    let isRewardGranted: Bool
}

enum AssignmentStatus: String {
    case notStarted = "NotStarted"
    case accepted = "Accepted"
    case completedByChild = "CompletedByChild"
    case wishRequest = "WishRequest"
    case unknown
    
    init(raw: String?) {
        self = AssignmentStatus(rawValue: raw ?? "") ?? .unknown
    }
    
    var wishyTab: WishyTab {
        switch self {
        case .notStarted: return .requests
        case .accepted: return .progress
        case .completedByChild: return .review
        case .wishRequest: return .requests
        case .unknown: return .progress
        }
    }
}
