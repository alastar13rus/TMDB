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
    }
    
}

extension MovieCoordinator : Equatable {
    static func == (lhs: MovieCoordinator, rhs: MovieCoordinator) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
}
