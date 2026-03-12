//
//  AchievementBadge.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

struct AchievementBadge: View {
    let achievement: KidsAchievement
    
    var body: some View {
        Text(achievement.emoji)
            .font(.system(size: 26))
            .frame(width: 60, height: 60)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(achievement.isUnlocked
                          ? Color(.systemGray5)
                          : Color(.systemGray6).opacity(0.5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(
                                achievement.isUnlocked
                                ? Color(.systemTeal).opacity(0.7)
                                : Color.clear,
                                lineWidth: 1.5
                            )
                    )
                    .shadow(
                        color: achievement.isUnlocked ? Color(.systemTeal).opacity(0.3) : .clear,
                        radius: 2, x: 0, y: 0
                    )
            )
            .grayscale(achievement.isUnlocked ? 0 : 0.8)
            .opacity(achievement.isUnlocked ? 1 : 0.4)
    }
}
