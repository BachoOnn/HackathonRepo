//
//  DIContainer.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import Foundation
import MyNetworkManager

final class DIContainer {
    static let shared = DIContainer()
    private init() {}
    
    // MARK: - Network
    lazy var networkManager: NetworkManager = NetworkManager()
    
    // MARK: - Repositories
    lazy var authRepository: AuthRepositoryProtocol = AuthRepository(network: networkManager)
    
    // MARK: - UseCases
    lazy var loginUseCase: LogInUseCase = DefaultLogInUseCase(authRepository: authRepository)
    
    // MARK: - ViewModels
    func makeLoginViewModel(coordinator: AppCoordinator) -> LoginViewModel {
        LoginViewModel(coordinator: coordinator, loginUseCase: loginUseCase)
    }
    
    func makeParentHomeViewModel(coordinator: AppCoordinator) -> ParentHomeViewModel {
        ParentHomeViewModel(coordinator: coordinator)
    }
    
    func makeParentWishyViewModel(coordinator: AppCoordinator) -> ParentWishyViewModel {
        ParentWishyViewModel(coordinator: coordinator)
    }
    
    func makeKidsHomeViewModel(coordinator: AppCoordinator) -> KidsHomeViewModel {
        KidsHomeViewModel(coordinator: coordinator)
    }
    
    func makeKidsWishyViewModel() -> KidsWishyViewModel {
        KidsWishyViewModel()
    }
}
