//
//  RootView.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import SwiftUI

struct RootView: View {
    @StateObject var coordinator = AppCoordinator()
    
    var body: some View {
        Group {
            switch coordinator.userRole {
            case .none:
                LoginView(viewModel: LoginViewModel(coordinator: coordinator))
            case .parent:
                NavigationStack(path: $coordinator.path) {
                    ParentHomeView(viewModel: ParentHomeViewModel(coordinator: coordinator))
                        .navigationBarHidden(true)
                        .navigationDestination(for: AppRoute.self) { route in
                            destination(for: route)
                        }
                }
            case .kid:
                NavigationStack(path: $coordinator.path) {
                    KidsHomeView(viewModel: KidsHomeViewModel(coordinator: coordinator))
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
            ParentsWishyView(viewModel: ParentWishyViewModel(coordinator: coordinator))
        case .kidsWishy:
            KidsWishyView(viewModel: KidsWishyViewModel())
        }
    }
}

#Preview {
    RootView()
}
