//
//  KidsHomeViewModel.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import Combine

final class KidsHomeViewModel: ObservableObject {
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func navigateToWishy() {
        coordinator.push(.kidsWishy)
    }
}
