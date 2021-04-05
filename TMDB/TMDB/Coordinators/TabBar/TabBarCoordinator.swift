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
    let tabBarController: UITabBarController
    let items: [UINavigationController]
    
    init(window: UIWindow, tabBarController: UITabBarController) {
        self.window = window
        self.tabBarController = tabBarController
        
        let dataSource = TabBarDataSource()
        self.items = dataSource.items
        
        tabBarController.setViewControllers(items, animated: true)
        tabBarController.selectedViewController = items[0]
    }
    
    func start() {
        window.rootViewController = tabBarController
        self.showMovieTab()
        
    }
    
    public func showMovieTab() {
        let movieListCoordinator = MovieListCoordinator(window: window, navigationController: items[0])
        coordinate(to: movieListCoordinator)
    }
    
    public func showTVTab() {
//        let tvListCoordinator = TVListCoordinator(window: window, navigationController: items[0])
//        coordinate(to: tvListCoordinator)
    }
    
    public func showFavoriteTab() {
//        let favoriteListCoordinator = FavoriteListCoordinator(window: window, navigationController: items[0])
//        coordinate(to: favoriteListCoordinator)
    }
    
    
}


extension TabBarCoordinator : Equatable {
    static func == (lhs: TabBarCoordinator, rhs: TabBarCoordinator) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
}
