//
//  WishyTaskRow.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import SwiftUI

struct WishyTaskRow: View {
    let task: WishyTask
    
    var body: some View {
        HStack(spacing: 14) {
            Text(task.emoji)
                .font(.system(size: 28))
                .frame(width: 52, height: 52)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray5))
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.primary)
                
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.system(size: 11))
                        .foregroundStyle(Color(.systemGray))
                    Text(task.due)
                        .font(.system(size: 12))
                        .foregroundStyle(Color(.systemGray))
                }
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Image("coin")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("\(task.reward)")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color(.systemYellow))
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemGray6))
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
        )
    }
}
