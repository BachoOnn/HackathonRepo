//
//  SectionCard.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import SwiftUI


struct SectionCard<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(.systemGray6))
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
            )
            .padding(.horizontal, 16)
    }
}
