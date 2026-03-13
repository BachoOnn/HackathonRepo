//
//  Wish.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//


struct Wish: Identifiable {
    let id: Int
    let title: String
    let description: String?
    let coinPrice: Int?
    let status: WishStatus
}

enum WishStatus: String {
    case pendingPrice = "PendingPrice"
    case priced = "Priced"
    case redeemed = "Redeemed"
    case unknown

    init(raw: String?) {
        self = WishStatus(rawValue: raw ?? "") ?? .unknown
    }
}