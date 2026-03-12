//
//  TBCBackground.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//


import SwiftUI

struct TBCBackground: View {
    @Environment(\.colorScheme) var colorScheme

    var gradientColors: [Color] {
        if colorScheme == .dark {
            return [
                Color(red: 0.05, green: 0.11, blue: 0.22),
                Color(red: 0.08, green: 0.20, blue: 0.38)
            ]
        } else {
            return [
                Color(red: 0.75, green: 0.88, blue: 0.96),
                Color(red: 0.88, green: 0.95, blue: 0.99) 
            ]
        }
    }

    var body: some View {
        LinearGradient(
            colors: gradientColors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}
