//
//  LoginRequestDTO.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import Foundation

struct LoginRequestDTO: Codable, @unchecked Sendable {
    let email: String
    let password: String
}
