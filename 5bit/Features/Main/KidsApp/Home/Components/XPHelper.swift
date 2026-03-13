//
//  XPHelper.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

struct XPHelper {
    private static let thresholds = [0, 150, 350, 700, 1200]
    
    static func xp(from coins: Int) -> Int {
        coins * 10
    }
    
    static func level(from xp: Int) -> Int {
        var level = 1
        for (i, threshold) in thresholds.enumerated() {
            if xp >= threshold { level = i + 1 }
        }
        return min(5, level)
    }
    
    static func xpForNextLevel(currentLevel: Int) -> Int {
        guard currentLevel < 5 else { return thresholds[4] }
        return thresholds[currentLevel] 
    }
    
    static func xpProgress(xp: Int) -> Double {
        let level = level(from: xp)
        if level >= 5 { return 1.0 }
        let base = thresholds[level - 1]
        let next = thresholds[level]
        return Double(xp - base) / Double(next - base)
    }
    
    static func xpInCurrentLevel(xp: Int) -> Int { xp }
}
