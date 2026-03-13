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
    lazy var taskRepository: TaskRepositoryProtocol = TaskRepository(network: networkManager)
    lazy var kidRepository: KidRepositoryProtocol = KidRepository(network: networkManager)
    
    // MARK: - UseCases
    lazy var loginUseCase: LogInUseCase = DefaultLogInUseCase(authRepository: authRepository)
    lazy var getParentAssignmentsUseCase: GetParentAssignmentsUseCase = DefaultGetParentAssignmentsUseCase(taskRepository: taskRepository)
    lazy var getChildBalanceUseCase: GetChildBalanceUseCase = DefaultGetChildBalanceUseCase(taskRepository: taskRepository)
    lazy var createAndAssignTaskUseCase: CreateAndAssignTaskUseCase = DefaultCreateAndAssignTaskUseCase(taskRepository: taskRepository)
    lazy var getKidDataUseCase: GetKidDataUseCase = DefaultGetKidDataUseCase(
        kidRepository: kidRepository,
        taskRepository: taskRepository
    )
    lazy var acceptTaskUseCase: AcceptTaskUseCase = DefaultAcceptTaskUseCase(kidRepository: kidRepository)
    lazy var completeTaskUseCase: CompleteTaskUseCase = DefaultCompleteTaskUseCase(kidRepository: kidRepository)
    lazy var createWishUseCase: CreateWishUseCase = DefaultCreateWishUseCase(kidRepository: kidRepository)
    lazy var approveTaskUseCase: ApproveTaskUseCase = DefaultApproveTaskUseCase(taskRepository: taskRepository)
    
    // MARK: - ViewModels
    func makeLoginViewModel(coordinator: AppCoordinator) -> LoginViewModel {
        LoginViewModel(coordinator: coordinator, loginUseCase: loginUseCase)
    }
    
    func makeParentHomeViewModel(coordinator: AppCoordinator) -> ParentHomeViewModel {
        ParentHomeViewModel(coordinator: coordinator)
    }
    
    
    func makeParentWishyViewModel(coordinator: AppCoordinator) -> ParentWishyViewModel {
        ParentWishyViewModel(
            coordinator: coordinator,
            getParentAssignmentsUseCase: getParentAssignmentsUseCase,
            getBalanceUseCase: getChildBalanceUseCase,
            approveTaskUseCase: approveTaskUseCase
        )
    }
    
    func makeAddTaskViewModel(parentId: Int, kids: [KidProfile]) -> AddTaskViewModel {
        AddTaskViewModel(
            parentId: parentId,
            kids: kids,
            createAndAssignUseCase: createAndAssignTaskUseCase
        )
    }
    
    func makeKidsHomeViewModel(coordinator: AppCoordinator) -> KidsHomeViewModel {
        KidsHomeViewModel(coordinator: coordinator, getKidDataUseCase: getKidDataUseCase)
    }
    
    func makeKidsWishyViewModel(coordinator: AppCoordinator) -> KidsWishyViewModel {
        KidsWishyViewModel(
            coordinator: coordinator,
            getKidDataUseCase: getKidDataUseCase,
            acceptTaskUseCase: acceptTaskUseCase,
            completeTaskUseCase: completeTaskUseCase
        )
    }
    
    func makeRequestViewModel(childId: Int) -> RequestViewModel {
        RequestViewModel(childId: childId, createWishUseCase: createWishUseCase)
    }
}
