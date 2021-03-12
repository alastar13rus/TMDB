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
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let movieCoordinator = MovieCoordinator()
        coordinate(to: movieCoordinator)
    }
    
    
}
