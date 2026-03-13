//
//  Transaction.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//


import Foundation

struct Transaction: Identifiable {
    let id: Int
    let amount: Int
    let type: String
    let reason: String
    let createdAt: Date
}