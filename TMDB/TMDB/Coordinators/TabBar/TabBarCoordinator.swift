//
//  TabBarCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 05.04.2021.
//

import UIKit
import Swinject

class TabBarCoordinator: Coordinator {
    
    var identifier = UUID()
    var childCoordinators = [UUID : Coordinator]()
    var parentCoordinator: Coordinator?
    
    let container: Container
    let window: UIWindow
    let items: [UINavigationController]
    let dataSource = TabBarControllerDataSource()
    
    lazy var tabBarController: TabBarController = {
        let tabBarController = TabBarController()
        tabBarController.coordinator = self
        tabBarController.setViewControllers(items, animated: true)
        tabBarController.selectedViewController = items[0]
        return tabBarController
    }()
    
    init(window: UIWindow, container: Container) {
        self.window = window
        self.items = dataSource.items
        self.container = container
    }
    
    func start() {
        window.rootViewController = tabBarController
        self.showMovieTab()
        
    }
    
    public func showMovieTab() {
        let movieFlowCoordinator = MovieFlowCoordinator(navigationController: items[0], container: container)
        coordinate(to: movieFlowCoordinator)
    }
    
    public func showTVTab() {
        let tvFlowCoordinator = TVFlowCoordinator(navigationController: items[1], container: container)
        coordinate(to: tvFlowCoordinator)
    }
    
    public func showFavoriteTab() {
        
    }
    
    
}


extension TabBarCoordinator : Equatable {
    static func == (lhs: TabBarCoordinator, rhs: TabBarCoordinator) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
}
