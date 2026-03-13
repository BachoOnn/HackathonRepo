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
