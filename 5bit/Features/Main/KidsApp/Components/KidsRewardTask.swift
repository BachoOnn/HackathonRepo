//
//  KidsRewardTask.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import Foundation
import SwiftUI

struct KidsRewardTask: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
    let description: String?
    let reward: Int
    let xp: Int
    let due: String?
    let timeLabel: String
    let isCompleted: Bool
    let isRecent: Bool
    let accentColor: Color
}

extension KidsRewardTask {
    static let mock: [KidsRewardTask] = [
        KidsRewardTask(emoji: "🧹", title: "Cleaned my room",    description: nil,                                        reward: 10, xp: 50, due: nil,         timeLabel: "2 hours ago", isCompleted: false, isRecent: true,  accentColor: .orange),
        KidsRewardTask(emoji: "🐕", title: "Walked the dog",     description: nil,                                        reward: 8,  xp: 40, due: nil,         timeLabel: "Yesterday",   isCompleted: false, isRecent: true,  accentColor: .yellow),
        KidsRewardTask(emoji: "🧹", title: "Clean Your Room",    description: "Organize your room and put everything in its place", reward: 10, xp: 50, due: "Today",     timeLabel: "Today",       isCompleted: false, isRecent: false, accentColor: .orange),
        KidsRewardTask(emoji: "🐕", title: "Walk the Dog",       description: "Take Rex to the park for a walk",          reward: 8,  xp: 40, due: "Tomorrow",  timeLabel: "Tomorrow",    isCompleted: false, isRecent: false, accentColor: Color(.systemTeal)),
        KidsRewardTask(emoji: "📚", title: "Read a Book",        description: "Read at least one chapter from your book", reward: 15, xp: 80, due: "Saturday",  timeLabel: "Saturday",    isCompleted: false, isRecent: false, accentColor: .purple),
        KidsRewardTask(emoji: "🛒", title: "Helped with groceries", description: nil,                                     reward: 12, xp: 60, due: nil,         timeLabel: "Yesterday",   isCompleted: true,  isRecent: false, accentColor: .green),
        KidsRewardTask(emoji: "🌿", title: "Watered the plants", description: nil,                                        reward: 6,  xp: 30, due: nil,         timeLabel: "2 days ago",  isCompleted: true,  isRecent: false, accentColor: .green),
    ]
}
