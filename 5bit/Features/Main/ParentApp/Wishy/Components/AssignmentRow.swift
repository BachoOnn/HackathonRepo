//
//  AssignmentRow.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

struct AssignmentRow: View {
    let assignment: Assignment
    var onApprove: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 14) {
                Text(statusEmoji)
                    .font(.system(size: 20))
                    .frame(width: 42, height: 42)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray5)))
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(assignment.taskTitle)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.primary)
                    
                    if let desc = assignment.taskDescription, !desc.isEmpty {
                        Text(desc)
                            .font(.system(size: 12))
                            .foregroundStyle(Color(.systemGray))
                            .lineLimit(2)
                    } else {
                        Text(assignment.childName)
                            .font(.system(size: 12))
                            .foregroundStyle(Color(.systemGray))
                    }
                }
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image("coin").resizable().frame(width: 16, height: 16)
                    Text("\(assignment.coinReward)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color(.systemYellow))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            if let onApprove {
                Button(action: onApprove) {
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 14))
                        Text("Approve & Grant Coins")
                            .font(.system(size: 14, weight: .bold))
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGreen)))
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            }
        }
    }
    
    private var statusEmoji: String {
        switch assignment.status {
        case .notStarted:       return "📋"
        case .accepted:         return "⚡️"
        case .completedByChild: return "✅"
        case .wishRequest:      return "⭐️"
        default:                return "🏆"
        }
    }
}
