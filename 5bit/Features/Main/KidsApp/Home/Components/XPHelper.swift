//
//  XPHelper.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

struct XPHelper {
    static func xp(from coins: Int) -> Int {
        coins * 10
    }
    
    static func level(from xp: Int) -> Int {
        min(5, (xp / 100) + 1)
    }
    
    static func xpForNextLevel(currentLevel: Int) -> Int {
        currentLevel * 100
    }
    
    static func xpProgress(xp: Int) -> Double {
        let level = level(from: xp)
        if level >= 5 { return 1.0 }
        return Double(xp % 100) / 100.0
    }
    
    static func xpInCurrentLevel(xp: Int) -> Int { xp }
}
