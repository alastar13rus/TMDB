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
    let navigationController: UINavigationController
    
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        let movieListCoordinator = MovieListCoordinator(window: window, navigationController: navigationController)
        coordinate(to: movieListCoordinator)
    }
    
    
}
