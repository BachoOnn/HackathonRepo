//
//  MissionCard.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

struct MissionCard: View {
    let task: KidsRewardTask
    
    var body: some View {
        HStack(spacing: 14) {
            Text(task.emoji)
                .font(.system(size: 30))
                .frame(width: 60, height: 60)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color(.systemGray5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .strokeBorder(task.accentColor.opacity(0.5), lineWidth: 1.5)
                        )
                )
            
            VStack(alignment: .leading, spacing: 6) {
                Text(task.title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.primary)
                
                if let desc = task.description {
                    Text(desc)
                        .font(.system(size: 12))
                        .foregroundStyle(Color(.systemGray))
                        .lineLimit(2)
                }
                
                HStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Image("coin")
                            .resizable()
                            .frame(width: 14, height: 14)
                        Text("\(task.reward)₾")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(Color(.systemYellow))
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Capsule().fill(Color(.systemYellow).opacity(0.15)))
                    
                    HStack(spacing: 4) {
                        Image(systemName: "bolt.fill")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(Color.purple)
                        Text("\(task.xp) XP")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(Color.purple)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Capsule().fill(Color.purple.opacity(0.15)))
                    
                    if let due = task.due {
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .font(.system(size: 10))
                                .foregroundStyle(Color(.systemGray))
                            Text(due)
                                .font(.system(size: 12))
                                .foregroundStyle(Color(.systemGray))
                        }
                    }
                }
            }
            
            Spacer()
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemGray6))
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .strokeBorder(task.accentColor.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
        )
    }
}
