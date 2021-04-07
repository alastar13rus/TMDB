//
//  AppCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.03.2021.
//

import UIKit

class AppCoordinator: Coordinator {

    var identifier = UUID()
    var childCoordinators = [UUID : Coordinator]()
    var parentCoordinator: Coordinator?
    
    let window: UIWindow
    let tabBarController: UITabBarController
    
    init(window: UIWindow, tabBarController: UITabBarController) {
        self.window = window
        self.tabBarController = tabBarController
    }
    
    func start() {
        let tabBarCoordinator = TabBarCoordinator(window: window)
        coordinate(to: tabBarCoordinator)
    }
    
    
}
