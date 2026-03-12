//
//  NotificationIconButton.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import SwiftUI

struct NotificationIconButton: View {
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: icon)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundStyle(Color(.label))
                
                Circle()
                    .fill(Color(.systemBlue))
                    .frame(width: 8, height: 8)
                    .offset(x: 2, y: -2)
            }
        }
    }
}
