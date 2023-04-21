//
//  MainTabBarController.swift
//  LampaTestApp
//
//  Created by Олександр Макогоненко on 18.04.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: Lets & Vars
    let homeVC: HomeScreenViewController
    let favouritesVC: HomeScreenViewController
    
    // MARK: View LifeCycle
    init(homeVC: HomeScreenViewController, favouritesVC: HomeScreenViewController) {
        self.homeVC = homeVC
        self.favouritesVC = favouritesVC
        super.init(nibName: ControllersNames.mainTabBarViewController, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(ControllersNames.failedInit)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // MARK: SetupView
    private func setupTabBar() {
        tabBar.backgroundColor = .white
        let homeNavController = UINavigationController(rootViewController: homeVC)
        let favouritesNavController = UINavigationController(rootViewController: favouritesVC)
        self.viewControllers = [homeNavController, favouritesNavController]
        
        homeNavController.tabBarItem = UITabBarItem(title: Constants.homeTabBarItemTitle,
                                                    image: UIImage(named: ImagesNames.homeButton),
                                                    selectedImage: UIImage(named: ImagesNames.homeButtonSelected))
        
        favouritesNavController.tabBarItem = UITabBarItem(title: Constants.favouritesTabBarItemTitle,
                                                          image: UIImage(named: ImagesNames.favouritesButton),
                                                          selectedImage: UIImage(named: ImagesNames.selectedFavouritesButton))
    }
}

// MARK: Constants
fileprivate enum Constants {
    static let homeTabBarItemTitle = "Home"
    static let favouritesTabBarItemTitle = "Favourite"
}
