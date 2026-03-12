//
//  RewardRow.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

struct RewardRow: View {
    let task: KidsRewardTask
    
    var body: some View {
        HStack(spacing: 14) {
            Text(task.emoji)
                .font(.system(size: 22))
                .frame(width: 46, height: 46)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray5))
                )
                .grayscale(task.isCompleted ? 0.6 : 0)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(task.title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(task.isCompleted ? Color(.systemGray) : .primary)
                    .strikethrough(task.isCompleted, color: Color(.systemGray))
                
                Text(task.timeLabel)
                    .font(.system(size: 12))
                    .foregroundStyle(Color(.systemGray))
            }
            
            Spacer()
            
            Text("+\(task.reward)₾")
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(Color(.systemGreen))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}
