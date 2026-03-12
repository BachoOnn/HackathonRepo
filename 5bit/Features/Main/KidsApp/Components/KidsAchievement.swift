//
//  KidsAchievement.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import Foundation

struct KidsAchievement: Identifiable {
    let id = UUID()
    let emoji: String
    let isUnlocked: Bool
}

extension KidsAchievement {
    static let mock: [KidsAchievement] = [
        KidsAchievement(emoji: "🥇", isUnlocked: true),
        KidsAchievement(emoji: "⚡️", isUnlocked: true),
        KidsAchievement(emoji: "🔥", isUnlocked: true),
        KidsAchievement(emoji: "💰", isUnlocked: false),
        KidsAchievement(emoji: "👑", isUnlocked: false),
    ]
}
