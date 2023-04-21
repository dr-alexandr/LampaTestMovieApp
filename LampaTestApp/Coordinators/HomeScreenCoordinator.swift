//
//  HomeScreenCoordinator.swift
//  LampaTestApp
//
//  Created by Олександр Макогоненко on 18.04.2023.
//

import UIKit

final class HomeScreenCoordinator: CoordinatorProtocol {
    
    // Vars
    var rootViewController = UIViewController()
    
    // Stubs
    func start() {
        
        // Creating First Controller for TabBar
        let homeStoryboard = UIStoryboard(name: ControllersNames.homeScreenViewController, bundle: nil)
        guard let homeController = homeStoryboard.instantiateViewController(withIdentifier: ControllersNames.homeScreenViewController)
                as? HomeScreenViewController
        else {return}
        
        homeController.useCase = .popular
        homeController.viewModel.coordinator = self

        // Creating Second Controller for TabBar
        let favouritesStoryboard = UIStoryboard(name: ControllersNames.homeScreenViewController, bundle: nil)
        guard let favouritesController = favouritesStoryboard.instantiateViewController(withIdentifier: ControllersNames.homeScreenViewController)
                as? HomeScreenViewController
        else {return}
        
        favouritesController.useCase = .topRated
        favouritesController.viewModel.coordinator = self
        
        // Setting TabBar with created Controllers
        let mainTabBarController = MainTabBarController(homeVC: homeController, favouritesVC: favouritesController)
        
        mainTabBarController.homeVC.viewModel.view = mainTabBarController.homeVC
        mainTabBarController.favouritesVC.viewModel.view = mainTabBarController.favouritesVC
        
        mainTabBarController.homeVC.viewModel.coordinator = self
        mainTabBarController.favouritesVC.viewModel.coordinator = self

        rootViewController = mainTabBarController
    }
}
