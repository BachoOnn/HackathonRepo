//
//  TransactionResponseDTO.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//


struct TransactionResponseDTO: Codable {
    let id: Int
    let childId: Int
    let amount: Int
    let moneyAmount: Double
    let transactionType: String?
    let reason: String?
    let createdAt: String
}