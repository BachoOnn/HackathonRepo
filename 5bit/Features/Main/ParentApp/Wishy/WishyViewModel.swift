//
//  WishyViewModel.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import Combine

final class WishyViewModel: ObservableObject {
    @Published var selectedTab: WishyTab = .progress
    @Published var selectedKid: KidProfile = KidProfile.mock[0]
    
    let kids: [KidProfile] = KidProfile.mock
    let tasks: [WishyTask] = WishyTask.mock
    
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    var filteredTasks: [WishyTask] {
        tasks.filter { $0.kidId == selectedKid.id && $0.tab == selectedTab }
    }
    
    func taskCount(for tab: WishyTab) -> Int {
        tasks.filter { $0.kidId == selectedKid.id && $0.tab == tab }.count
    }
    
    func selectKid(_ kid: KidProfile) {
        selectedKid = kid
        selectedTab = .progress
    }
    
    func navigateBack() {
        coordinator.pop()
    }
}
