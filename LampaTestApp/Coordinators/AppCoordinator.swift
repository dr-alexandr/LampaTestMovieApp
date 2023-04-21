//
//  AppCoordinator.swift
//  LampaTestApp
//
//  Created by Олександр Макогоненко on 18.04.2023.
//

import UIKit

protocol CoordinatorProtocol {
    func start()
}

final class AppCoordinator: CoordinatorProtocol {
    
    let window: UIWindow
    var coordinators: [CoordinatorProtocol] = []
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        runMainFlow()
    }
}

extension AppCoordinator {
    private func runMainFlow() {
        let homeScreenCoordinator = HomeScreenCoordinator()
        self.coordinators = [homeScreenCoordinator]
        homeScreenCoordinator.start()
        window.rootViewController = homeScreenCoordinator.rootViewController
    }
}
