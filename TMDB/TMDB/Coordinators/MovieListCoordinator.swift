//
//  MovieListCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.03.2021.
//

import UIKit

class MovieListCoordinator: NavigationCoordinator {
    
    var identifier = UUID()
    var childCoordinators = [UUID : Coordinator]()
    var parentCoordinator: Coordinator?
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        (_, _, _) = factory(vmType: MediaListViewModel.self, vcType: MediaListViewController.self)
    }
    
}



extension MovieListCoordinator : Equatable {
    static func == (lhs: MovieListCoordinator, rhs: MovieListCoordinator) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
}
