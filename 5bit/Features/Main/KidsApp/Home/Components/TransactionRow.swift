//
//  TransactionRow.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction

    var body: some View {
        HStack(spacing: 14) {
            Text(typeEmoji)
                .font(.system(size: 22))
                .frame(width: 44, height: 44)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray5)))

            VStack(alignment: .leading, spacing: 3) {
                Text(typeLabel)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.primary)
                Text(transaction.reason.isEmpty ? typeLabel : transaction.reason)
                    .font(.system(size: 12))
                    .foregroundStyle(Color(.systemGray))
                    .lineLimit(1)
            }

            Spacer()

            Text("+\(transaction.amount)")
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(Color(.systemGreen))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    private var typeEmoji: String {
        switch transaction.type {
        case "TaskReward": return "⚡️"
        case "WishRedemption": return "⭐️"
        case "MoneyConversion": return "💰"
        default: return "🪙"
        }
    }

    private var typeLabel: String {
        switch transaction.type {
        case "TaskReward": return "Task Reward"
        case "WishRedemption": return "Wish Redeemed"
        case "MoneyConversion": return "Converted to Money"
        default: return "Transaction"
        }
    }
}
