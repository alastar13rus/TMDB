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
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {

        let movieListViewController = MovieListViewController()
        let movieListViewModel = MovieListViewModel()
        movieListViewModel.coordinator = self
        movieListViewController.bindViewModel(to: movieListViewModel)
        
        window?.rootViewController = movieListViewController
        
        
//        let networkManager = NetworkManager()
//        networkManager.request(TmdbAPI.movies(.popular(page: 1))) { (result: Result<MovieListResponse, Error>) in
//            switch result {
//            case .success(let list):
//                print(list)
//            case .failure(_): break
//
//            }
//        }
    }
    
}

extension MovieListCoordinator : Equatable {
    static func == (lhs: MovieListCoordinator, rhs: MovieListCoordinator) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
}
