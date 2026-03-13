//
//  KidProfile.swift
//  5bit
//

import Foundation

struct KidProfile: Identifiable {
    let id = UUID()
    let apiId: Int
    let emoji: String
    let name: String
    let balance: Int
    let completedTasks: Int
    let totalTasks: Int
    let progress: Double
}

extension KidProfile {
    static let mock: [KidProfile] = [
        KidProfile(apiId: 2, emoji: "👧🏼", name: "Alice", balance: 45, completedTasks: 3, totalTasks: 5, progress: 0.6),
        KidProfile(apiId: 3, emoji: "👦🏻", name: "Bob",   balance: 30, completedTasks: 2, totalTasks: 4, progress: 0.5),
        KidProfile(apiId: 4, emoji: "🧒", name: "Charlie", balance: 20, completedTasks: 1, totalTasks: 3, progress: 0.33),
    ]
}
