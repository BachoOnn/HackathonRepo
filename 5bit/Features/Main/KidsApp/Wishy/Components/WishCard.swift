//
//  WishCard.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

struct WishCard: View {
    let wish: Wish
    let onRedeem: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Text("⭐️")
                .font(.system(size: 26))
                .frame(width: 50, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.purple.opacity(0.15))
                        .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.purple, lineWidth: 1.5))
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(wish.title)
                    .font(.system(size: 15, weight: .bold))
                if let desc = wish.description, !desc.isEmpty {
                    Text(desc)
                        .font(.system(size: 12))
                        .foregroundStyle(Color(.systemGray))
                        .lineLimit(2)
                }
                statusBadge
            }

            Spacer()

            if wish.status == .priced, let price = wish.coinPrice {
                Button(action: onRedeem) {
                    VStack(spacing: 2) {
                        HStack(spacing: 4) {
                            Image("coin").resizable().frame(width: 14, height: 14)
                            Text("\(price)")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundStyle(Color(.systemYellow))
                        }
                        Text("Redeem")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.purple))
                }
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6))
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
        )
    }

    private var statusBadge: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(badgeColor)
                .frame(width: 6, height: 6)
            Text(statusLabel)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(badgeColor)
        }
    }

    private var statusLabel: String {
        switch wish.status {
        case .pendingPrice: return "Waiting for price"
        case .priced:       return "Ready to redeem!"
        case .redeemed:     return "Redeemed ✓"
        default:            return "Pending"
        }
    }

    private var badgeColor: Color {
        switch wish.status {
        case .pendingPrice: return Color(.systemOrange)
        case .priced:       return Color.purple
        case .redeemed:     return Color(.systemGreen)
        default:            return Color(.systemGray)
        }
    }
}
