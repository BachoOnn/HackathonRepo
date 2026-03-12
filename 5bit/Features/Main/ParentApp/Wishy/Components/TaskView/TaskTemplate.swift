//
//  TaskTemplate.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import Foundation

struct TaskTemplate: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
}

extension TaskTemplate {
    static let all: [TaskTemplate] = [
        TaskTemplate(emoji: "📚", title: "Read a book"),
        TaskTemplate(emoji: "🧹", title: "Clean room"),
        TaskTemplate(emoji: "💪", title: "Exercise"),
        TaskTemplate(emoji: "🎯", title: "Do homework"),
        TaskTemplate(emoji: "🎨", title: "Art project"),
        TaskTemplate(emoji: "🤔", title: "Other"),
    ]
}
