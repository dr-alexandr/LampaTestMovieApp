//
//  AppCoordinator.swift
//  LampaTestApp
//
//  Created by Олександр Макогоненко on 18.04.2023.
//

import UIKit

// MARK: Protocol
protocol CoordinatorProtocol {
    func start()
}

// MARK: Class
final class AppCoordinator: CoordinatorProtocol {
    
    // Lets & Vars
    let window: UIWindow
    var coordinators: [CoordinatorProtocol] = []
    
    // Initializer
    init(window: UIWindow) {
        self.window = window
    }
    
    // Stubs
    func start() {
        runMainFlow()
    }
}

// MARK: Flows implementation
extension AppCoordinator {
    private func runMainFlow() {
        let homeScreenCoordinator = HomeScreenCoordinator()
        self.coordinators = [homeScreenCoordinator]
        homeScreenCoordinator.start()
        window.rootViewController = homeScreenCoordinator.rootViewController
    }
}
