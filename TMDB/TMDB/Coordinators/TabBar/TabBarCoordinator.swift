//
//  TabBarCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 05.04.2021.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    var identifier = UUID()
    var childCoordinators = [UUID : Coordinator]()
    var parentCoordinator: Coordinator?
    
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
    
    init(window: UIWindow) {
        self.window = window
        self.items = dataSource.items
    }
    
    func start() {
        window.rootViewController = tabBarController
        self.showMovieTab()
        
    }
    
    public func showMovieTab() {
        let movieListCoordinator = MovieListCoordinator(navigationController: items[0])
        coordinate(to: movieListCoordinator)
    }
    
    public func showTVTab() {
        let tvListCoordinator = TVListCoordinator(navigationController: items[1])
        coordinate(to: tvListCoordinator)
    }
    
    public func showFavoriteTab() {
//        let favoriteListCoordinator = FavoriteListCoordinator(navigationController: items[2])
//        coordinate(to: favoriteListCoordinator)
    }
    
    
}


extension TabBarCoordinator : Equatable {
    static func == (lhs: TabBarCoordinator, rhs: TabBarCoordinator) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
}
