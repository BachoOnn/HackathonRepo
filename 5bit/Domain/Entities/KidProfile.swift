//
//  KidProfile.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import Foundation

struct KidProfile: Identifiable {
    let id: UUID
    let emoji: String
    let name: String
    let balance: Int
    let completedTasks: Int
    let totalTasks: Int
    
    var progress: Double {
        guard totalTasks > 0 else { return 0 }
        return Double(completedTasks) / Double(totalTasks)
    }
}

extension KidProfile {
    static let mock: [KidProfile] = [
        KidProfile(id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!, emoji: "🧒", name: "Alex",  balance: 28, completedTasks: 3, totalTasks: 5),
        KidProfile(id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!, emoji: "👧", name: "Sofia", balance: 14, completedTasks: 1, totalTasks: 4),
    ]
}
