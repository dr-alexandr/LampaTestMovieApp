//
//  SceneDelegate.swift
//  LampaTestApp
//
//  Created by Олександр Макогоненко on 19.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let appWindow = UIWindow(frame: scene.coordinateSpace.bounds)
        appWindow.windowScene = scene
        appCoordinator = AppCoordinator(window: appWindow)
        appCoordinator?.start()
        appWindow.makeKeyAndVisible()
        window = appWindow
    }
}
