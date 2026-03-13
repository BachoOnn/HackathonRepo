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
    let type: String
}

extension TaskTemplate {
    static let all: [TaskTemplate] = [
        TaskTemplate(emoji: "📚", title: "Read a book",  type: "Study"),
        TaskTemplate(emoji: "🧹", title: "Clean room",   type: "Chore"),
        TaskTemplate(emoji: "💪", title: "Exercise",     type: "Health"),
        TaskTemplate(emoji: "🎯", title: "Do homework",  type: "Study"),
        TaskTemplate(emoji: "🎨", title: "Art project",  type: "Creative"),
        TaskTemplate(emoji: "🤔", title: "Other",        type: "Other"),
    ]
}
