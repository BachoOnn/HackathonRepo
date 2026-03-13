//
//  LoginUseCase.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import Foundation

protocol LogInUseCase {
    func execute(email: String, password: String) async throws -> User
}

struct DefaultLogInUseCase: LogInUseCase {
    
    private let authRepository: AuthRepositoryProtocol
    
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    func execute(email: String, password: String) async throws -> User {
        
        guard !email.isEmpty else {
            throw AuthError.emptyEmail
        }
        
        guard !password.isEmpty else {
            throw AuthError.emptyPassword
        }
        
        guard isValidEmail(email) else {
            throw AuthError.invalidEmail
        }
        
        return try await authRepository.login(email: email, password: password)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let regex = #"^[A-Z0-9a-z._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"#
        return email.range(of: regex, options: .regularExpression) != nil
    }
}
