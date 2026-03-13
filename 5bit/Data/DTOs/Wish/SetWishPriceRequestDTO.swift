//
//  SetWishPriceRequestDTO.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

struct SetWishPriceRequestDTO: Codable {
    let wishId: Int
    let price: Int
    let parentId: Int
}
