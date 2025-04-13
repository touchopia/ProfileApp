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
        
        let viewController = ProfileViewController()
        viewController.view.backgroundColor = .white
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }
}

