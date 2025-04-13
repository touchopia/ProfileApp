//
//  SceneDelegate.swift
//  ProfileApp
//
//  Created by Phil Wright on 4/13/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Setup the window
        let window = UIWindow(windowScene: windowScene)
        
        // Tab Bar Controller as the root
        let tabBarController = UITabBarController()
                
        
        // Create view controllers
        
        let homeViewController = HomeViewController()
        
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let profileViewController = ProfileViewController()
        
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)

        // Add view controllers to tab bar
        tabBarController.viewControllers = [homeViewController, profileViewController]

        // Setup the window
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        self.window = window
    }
}

