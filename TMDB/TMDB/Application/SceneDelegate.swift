//
//  SceneDelegate.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 10.03.2021.
//

import UIKit
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appFlowCoordinator: Coordinator?
    var container = AppDIContainer.shared

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        guard let window = window else { return }
        window.makeKeyAndVisible()
        
        let tabBarController = UITabBarController()
        
        appFlowCoordinator = AppFlowCoordinator(window: window, tabBarController: tabBarController, container: container)
        appFlowCoordinator?.start()
        
    }

}

