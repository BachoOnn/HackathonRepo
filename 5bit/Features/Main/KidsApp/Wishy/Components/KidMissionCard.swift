//
//  KidMissionCard.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

struct KidMissionCard: View {
    let assignment: Assignment
    let onAccept: () -> Void
    let onComplete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Text(statusEmoji)
                    .font(.system(size: 26))
                    .frame(width: 50, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(accentColor.opacity(0.15))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .strokeBorder(accentColor, lineWidth: 1.5)
                            )
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(assignment.taskTitle)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.primary)
                    
                    if let desc = assignment.taskDescription, !desc.isEmpty {
                        Text(desc)
                            .font(.system(size: 12))
                            .foregroundStyle(Color(.systemGray))
                            .lineLimit(2)
                    }
                }
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image("coin").resizable().frame(width: 18, height: 18)
                    Text("\(assignment.coinReward)")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(Color(.systemYellow))
                }
            }
            
            actionButton
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6))
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
        )
    }
    
    @ViewBuilder
    private var actionButton: some View {
        switch assignment.status {
        case .notStarted:
            Button(action: onAccept) {
                Text("Accept Mission")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemBlue)))
            }
        case .accepted:
            Button(action: onComplete) {
                Text("Mark as Done")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color(.systemGreen)))
            }
        default:
            EmptyView()
        }
    }
    
    private var statusEmoji: String {
        switch assignment.status {
        case .notStarted: return "📋"
        case .accepted: return "⚡️"
        default: return "✅"
        }
    }
    
    private var accentColor: Color {
        switch assignment.status {
        case .notStarted: return Color(.systemBlue)
        case .accepted: return Color(.systemOrange)
        default: return Color(.systemGreen)
        }
    }
}
