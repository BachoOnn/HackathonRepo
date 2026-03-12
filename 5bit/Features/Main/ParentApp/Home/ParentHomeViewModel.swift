//
//  ParentHomeViewModel.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import Combine

final class ParentHomeViewModel: ObservableObject {
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func navigateToWishy() {
        coordinator.push(.parentWishy)
    }
}
