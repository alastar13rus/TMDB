//
//  AppFlowCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.03.2021.
//

import UIKit
import Swinject

class AppFlowCoordinator: Coordinator {

    var identifier = UUID()
    var childCoordinators = [UUID : Coordinator]()
    var parentCoordinator: Coordinator?
    
    let window: UIWindow
    let tabBarController: UITabBarController
    let container: Container
    
    init(window: UIWindow, tabBarController: UITabBarController, container: Container) {
        self.window = window
        self.tabBarController = tabBarController
        self.container = container
    }
    
    func start() {
        let tabBarCoordinator = TabBarCoordinator(window: window, container: container)
        coordinate(to: tabBarCoordinator)
    }
    
    
}
