//
//  AuthRepositoryProtocol.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//


import Foundation

protocol AuthRepositoryProtocol {
    func login(email: String, password: String) async throws -> User
}