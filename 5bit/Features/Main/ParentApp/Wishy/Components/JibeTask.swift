//
//  WishyTask.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import Foundation

struct WishyTask: Identifiable {
    let id = UUID()
    let kidId: UUID
    let emoji: String
    let title: String
    let due: String
    let reward: Int
    let tab: WishyTab
}

extension WishyTask {
    static let mock: [WishyTask] = [
        WishyTask(kidId: KidProfile.mock[0].id, emoji: "📚", title: "Read a book",   due: "Today 6:00 PM",    reward: 15, tab: .progress),
        WishyTask(kidId: KidProfile.mock[0].id, emoji: "🧹", title: "Clean room",    due: "Tomorrow 8:00 PM", reward: 10, tab: .progress),
        WishyTask(kidId: KidProfile.mock[0].id, emoji: "📝", title: "Do homework",   due: "Today 5:00 PM",    reward: 20, tab: .review),
        WishyTask(kidId: KidProfile.mock[1].id, emoji: "🛒", title: "Buy groceries", due: "Today 3:00 PM",    reward: 8,  tab: .requests),
        WishyTask(kidId: KidProfile.mock[1].id, emoji: "🚿", title: "Wash the car",  due: "Yesterday",        reward: 12, tab: .done),
        WishyTask(kidId: KidProfile.mock[1].id, emoji: "🌱", title: "Water plants",  due: "Today 7:00 PM",    reward: 5,  tab: .progress),
    ]
}
