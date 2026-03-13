//
//  Avatar.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

enum Avatar: String {
    case alice = "Alice"
    case bob = "Bob"
    case charlie = "Charlie"
    
    init(name: String) {
        self = Avatar(rawValue: name) ?? .alice
    }
    
    var emoji: String {
        switch self {
        case .alice:   return "👧🏼"
        case .bob:     return "👦🏻"
        case .charlie: return "🧒🏽"
        }
    }
}
