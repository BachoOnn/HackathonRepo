//
//  LoginViewModel.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import Combine
import Foundation

@MainActor
final class LoginViewModel: ObservableObject {

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    private weak var coordinator: AppCoordinator?
    private let loginUseCase: LogInUseCase
    
    init(coordinator: AppCoordinator, loginUseCase: LogInUseCase) {
        self.coordinator = coordinator
        self.loginUseCase = loginUseCase
    }
    
    func login() {
        Task {
            await performLogin()
        }
    }
    
    func clearError() {
        errorMessage = nil
    }
}

fileprivate extension LoginViewModel {
    
    func performLogin() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let user = try await loginUseCase.execute(email: email, password: password)
            coordinator?.login(as: user.role)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
