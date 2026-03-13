//
//  LoginResponseDTO.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import Foundation

struct LoginResponseDTO: Codable, @unchecked Sendable {
    let userId: Int
    let name: String
    let role: String
    let parentId: Int?
}

extension LoginResponseDTO {
    func toDomain() throws -> User {
        guard let userRole = UserRole(rawValue: role.lowercased()) else {
            throw MappingError.unknownRole(role)
        }
        return User(
            userId: userId,
            name: name,
            role: userRole,
            parentId: parentId
        )
    }
}

enum MappingError: Error {
    case unknownRole(String)
}
