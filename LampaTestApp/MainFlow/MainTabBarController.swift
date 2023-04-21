//
//  MainTabBarController.swift
//  LampaTestApp
//
//  Created by Олександр Макогоненко on 18.04.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    let homeVC: HomeScreenViewController
    let favouritesVC: HomeScreenViewController
    
    init(homeVC: HomeScreenViewController, favouritesVC: HomeScreenViewController) {
        self.homeVC = homeVC
        self.favouritesVC = favouritesVC
        super.init(nibName: "MainTabBarController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white
        let homeNavController = UINavigationController(rootViewController: homeVC)
        let favouritesNavController = UINavigationController(rootViewController: favouritesVC)
        self.viewControllers = [homeNavController, favouritesNavController]
        
        homeNavController.tabBarItem = UITabBarItem(title: "Home",
                                                    image: UIImage(named: "HomeButton"),
                                                    selectedImage: UIImage(named: "HomeButtonSelected"))
        
        favouritesNavController.tabBarItem = UITabBarItem(title: "Favourite",
                                                          image: UIImage(named: "FavouritesButton"),
                                                          selectedImage: UIImage(named: "SelectedFavouritesButton"))
    }
    
    
    
}
