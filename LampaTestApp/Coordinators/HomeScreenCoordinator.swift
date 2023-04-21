//
//  HomeScreenCoordinator.swift
//  LampaTestApp
//
//  Created by Олександр Макогоненко on 18.04.2023.
//

import UIKit

final class HomeScreenCoordinator: CoordinatorProtocol {
    
    var rootViewController = UIViewController()
    
    func start() {
        
        let homeStoryboard = UIStoryboard(name: "HomeScreenViewController", bundle: nil)
        guard let homeController = homeStoryboard.instantiateViewController(withIdentifier: "HomeScreenViewController") as? HomeScreenViewController
        else {return}
        
        homeController.useCase = .popular
        homeController.viewModel.coordinator = self

        let favouritesStoryboard = UIStoryboard(name: "HomeScreenViewController", bundle: nil)
        guard let favouritesController = favouritesStoryboard.instantiateViewController(withIdentifier: "HomeScreenViewController") as? HomeScreenViewController
        else {return}
        
        favouritesController.useCase = .topRated
        favouritesController.viewModel.coordinator = self
        
        let mainTabBarController = MainTabBarController(homeVC: homeController, favouritesVC: favouritesController)
        
        mainTabBarController.homeVC.viewModel.view = mainTabBarController.homeVC
        mainTabBarController.favouritesVC.viewModel.view = mainTabBarController.favouritesVC
        
        mainTabBarController.homeVC.viewModel.coordinator = self
        mainTabBarController.favouritesVC.viewModel.coordinator = self

        rootViewController = mainTabBarController
    }
}
