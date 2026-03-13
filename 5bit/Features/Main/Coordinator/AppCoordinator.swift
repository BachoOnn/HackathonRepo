//
//  AppCoordinator.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import Combine
import SwiftUI

final class AppCoordinator: ObservableObject {
    @Published var userRole: UserRole? = nil
    @Published var path = NavigationPath()
    @Published var currentUser: User? = nil
    
    func login(as role: UserRole, user: User) {
        currentUser = user
        userRole = role
    }

    func push(_ route: AppRoute) {
        path.append(route)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

    func logout() {
        userRole = nil
        path = NavigationPath()
    }
}
