//
//  MovieListCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.03.2021.
//

import UIKit

class MovieListCoordinator: Coordinator {
    
    var identifier = UUID()
    var childCoordinators = [UUID : Coordinator]()
    var parentCoordinator: Coordinator?
    
    let window: UIWindow?
    let navigationController: UINavigationController
    
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        let (_, _, _) = factory()
        window?.rootViewController = navigationController
    }
    
    func factory() -> (coordinator: MovieListCoordinator, viewModel: MovieListViewModel, viewController: MovieListViewController) {
        
        let networkManager: NetworkManagerProtocol = NetworkManager()
        
        let movieListViewController = MovieListViewController()
        let movieListViewModel = MovieListViewModel(networkManager: networkManager)
        movieListViewModel.coordinator = self
        movieListViewController.bindViewModel(to: movieListViewModel)
        navigationController.viewControllers = [movieListViewController]
        return (self, movieListViewModel, movieListViewController)
    }
    
}



extension MovieListCoordinator : Equatable {
    static func == (lhs: MovieListCoordinator, rhs: MovieListCoordinator) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
}
