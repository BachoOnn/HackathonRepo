//
//  WishResponseDTO.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

struct WishResponseDTO: Codable {
    let id: Int
    let childId: Int
    let title: String?
    let description: String?
    let coinPrice: Int?
    let status: String?
    let createdAt: String?  
    let redeemedAt: String?
}
