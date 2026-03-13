//
//  RequestCategory.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import Foundation

struct RequestCategory: Identifiable {
    let id = UUID()
    let emoji: String
    let label: String
}

extension RequestCategory {
    static let taskCategories: [RequestCategory] = [
        RequestCategory(emoji: "🧹", label: "Cleaning"),
        RequestCategory(emoji: "🛒", label: "Shopping"),
        RequestCategory(emoji: "🐕", label: "Pet Care"),
        RequestCategory(emoji: "📚", label: "Study"),
        RequestCategory(emoji: "🍳", label: "Cooking"),
        RequestCategory(emoji: "🌿", label: "Garden"),
    ]

    static let wishCategories: [RequestCategory] = [
        RequestCategory(emoji: "🎮", label: "Games"),
        RequestCategory(emoji: "👟", label: "Clothes"),
        RequestCategory(emoji: "🍕", label: "Food"),
        RequestCategory(emoji: "🎨", label: "Art"),
        RequestCategory(emoji: "🏀", label: "Sports"),
        RequestCategory(emoji: "🎵", label: "Music"),
    ]
}
