//
//  TabBarCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 05.04.2021.
//

import UIKit
import Swinject

class TabBarCoordinator: Coordinator {
    
    private enum State {
        case movieTab
        case tvTab
        case searchTab
        case favoriteTab
    }
    
    var identifier = UUID()
    var childCoordinators = [UUID: Coordinator]()
    var parentCoordinator: Coordinator?
    
    let container: Container
    let window: UIWindow
    let items: [UINavigationController]
    let dataSource = TabBarControllerDataSource()
    
    private var state: State?
    
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
        if case .some(.movieTab) = state { return }
        
        guard let coordinator = childCoordinators.map({ $1 }).first(where: { $0 is MovieFlowCoordinator })
        else {
            let coordinator = MovieFlowCoordinator(navigationController: items[0], container: container)
            coordinate(to: coordinator)
            state = .movieTab
            return
        }
        
        coordinate(to: coordinator)
        state = .movieTab
    }
    
    public func showTVTab() {
        if case .some(.tvTab) = state { return }
        
        guard let coordinator = childCoordinators.map({ $1 }).first(where: { $0 is TVFlowCoordinator })
        else {
            let coordinator = TVFlowCoordinator(navigationController: items[1], container: container)
            coordinate(to: coordinator)
            state = .tvTab
            return
        }
        
        coordinate(to: coordinator)
        state = .tvTab
    }
    
    public func showSearchTab() {
        if case .some(.searchTab) = state { return }
        
        guard let coordinator = childCoordinators.map({ $1 }).first(where: { $0 is SearchFlowCoordinator })
        else {
            let coordinator = SearchFlowCoordinator(navigationController: items[2], container: container)
            coordinate(to: coordinator)
            state = .searchTab
            return
        }

        coordinate(to: coordinator)
        state = .searchTab
    }
    
    public func showFavoriteTab() {
        if case .some(.favoriteTab) = state { return }
        
        guard let coordinator = childCoordinators.map({ $1 }).first(where: { $0 is FavoriteFlowCoordinator })
        else {
            let coordinator = FavoriteFlowCoordinator(navigationController: items[3], container: container)
            coordinate(to: coordinator)
            state = .favoriteTab
            return
        }

        coordinate(to: coordinator)
        state = .favoriteTab
    }
    
}

extension TabBarCoordinator: Equatable {
    static func == (lhs: TabBarCoordinator, rhs: TabBarCoordinator) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
}
