//
//  AuthError.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//


import Foundation

enum AuthError: Error, LocalizedError {
    case emptyEmail
    case emptyPassword
    case emptyFields
    case invalidEmail
    case passwordMismatch
    case passwordTooShort
    case weakPassword
    
    var errorDescription: String? {
        switch self {
        case .emptyEmail: return "Email is required"
        case .emptyPassword: return "Password is required"
        case .emptyFields: return "Please fill in all fields"
        case .invalidEmail: return "Invalid email format"
        case .passwordMismatch: return "Passwords don't match"
        case .passwordTooShort: return "Password must be at least 6 characters"
        case .weakPassword: return "Password is weak! Must contain at least one uppercased letter"
        }
    }
}