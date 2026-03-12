//
//  WishyStatCell.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import SwiftUI

struct WishyStatCell: View {
    let icon: String
    let iconColor: UIColor
    let count: Int
    let label: String
    let tab: WishyTab
    @Binding var selectedTab: WishyTab
    
    private var isSelected: Bool { selectedTab == tab }
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedTab = tab
            }
        } label: {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(Color(iconColor))
                
                Text("\(count)")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.primary)
                
                Text(label)
                    .font(.system(size: 12))
                    .foregroundStyle(Color(.systemGray))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(
                                isSelected ? Color(iconColor) : Color.clear,
                                lineWidth: 1.5
                            )
                    )
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
            )
        }
    }
}
