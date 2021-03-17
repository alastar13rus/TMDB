//
//  SceneDelegate.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 10.03.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        guard let window = window else { return }
        window.makeKeyAndVisible()
        
        let navigationController = UINavigationController()
        
        appCoordinator = AppCoordinator(window: window, navigationController: navigationController)
        appCoordinator?.start()
        
    }

}

