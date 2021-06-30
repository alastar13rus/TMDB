//
//  FavoriteFlowCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 05.04.2021.
//

import UIKit
import Domain
import Swinject

class FavoriteFlowCoordinator: NavigationCoordinator {
    
// MARK: - Properties
    var container: Container
    var navigationController: UINavigationController
    var identifier = UUID()
    var childCoordinators = [UUID: Coordinator]()
    var parentCoordinator: Coordinator?
    
// MARK: - Init
    init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
// MARK: - Methods
    func start() {
        _ = container.resolve(Typealias.FavoriteBundle.self, argument: self)
    }
    
    func toMovie(with mediaID: String) {
        guard let movieFlowCoordinator = parentCoordinator as? MovieFlowCoordinator else {
            let movieFlowCoordinator = MovieFlowCoordinator(navigationController: navigationController, container: container)
            store(movieFlowCoordinator)
            movieFlowCoordinator.toDetail(with: mediaID)
            return
        }
        
        movieFlowCoordinator.toDetail(with: mediaID)
    }
    
    func toTV(with mediaID: String) {
        guard let tvFlowCoordinator = parentCoordinator as? TVFlowCoordinator else {
            let tvFlowCoordinator = TVFlowCoordinator(navigationController: navigationController, container: container)
            store(tvFlowCoordinator)
            tvFlowCoordinator.toDetail(with: mediaID)
            return
        }
        
        tvFlowCoordinator.toDetail(with: mediaID)
    }
}

extension FavoriteFlowCoordinator: ToPeopleRoutable { }
