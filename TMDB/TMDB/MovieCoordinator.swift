//
//  MovieCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.03.2021.
//

import Foundation

class MovieCoordinator: Coordinator {
    
    var identifier = UUID()
    var childCoordinators = [UUID : Coordinator]()
    var parentCoordinator: Coordinator?
    
    
    func start() {
        print("start \(Self.self)")
        let networkManager = NetworkManager()
        networkManager.request(TmdbAPI.movies(.popular(page: 1))) { (result: Result<MovieListResponse, Error>) in
            switch result {
            case .success(let list):
                print(list)
            case .failure(_): break
                
            }
        }
    }
    
}

extension MovieCoordinator : Equatable {
    static func == (lhs: MovieCoordinator, rhs: MovieCoordinator) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
}
