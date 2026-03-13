//
//  RootView.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import SwiftUI

struct RootView: View {
    @StateObject var coordinator = AppCoordinator()
    
    private let di = DIContainer.shared
    
    var body: some View {
        Group {
            switch coordinator.userRole {
            case .none:
                LoginView(viewModel: di.makeLoginViewModel(coordinator: coordinator))
            case .parent:
                NavigationStack(path: $coordinator.path) {
                    ParentHomeView(viewModel: di.makeParentHomeViewModel(coordinator: coordinator))
                        .navigationBarHidden(true)
                        .navigationDestination(for: AppRoute.self) { route in
                            destination(for: route)
                        }
                }
            case .child:
                NavigationStack(path: $coordinator.path) {
                    KidsHomeView(viewModel: di.makeKidsHomeViewModel(coordinator: coordinator))
                        .navigationBarHidden(true)
                        .navigationDestination(for: AppRoute.self) { route in
                            destination(for: route)
                        }
                }
            }
        }
    }
    
    @ViewBuilder
    private func destination(for route: AppRoute) -> some View {
        switch route {
        case .parentWishy:
            ParentsWishyView(viewModel: di.makeParentWishyViewModel(coordinator: coordinator))
        case .kidsWishy:
            KidsWishyView(viewModel: di.makeKidsWishyViewModel())
        }
    }
}

#Preview {
    RootView()
}
