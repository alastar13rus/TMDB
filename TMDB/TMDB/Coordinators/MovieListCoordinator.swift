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
    
    func toDetail(with detailID: String) {
        (_, _, _) = factory(with: detailID, vmType: MovieDetailViewModel.self, vcType: MovieDetailViewController.self)
    }
    
    func toCreditList(with detailID: String, params: [String: String]) {
        (_, _, _) = factory(with: detailID, vmType: CreditListViewModel.self, vcType: CreditListViewController.self, params: params)
    }
    
    func toPeople(with peopleID: String) {
        guard let peopleListCoordinator = parentCoordinator as? PeopleListCoordinator else {
            let peopleListCoordinator = PeopleListCoordinator(navigationController: navigationController)
            store(peopleListCoordinator)
            peopleListCoordinator.toDetail(with: peopleID)
            return
        }
        
        peopleListCoordinator.toDetail(with: peopleID)
    }
    
}



extension MovieListCoordinator : Equatable {
    static func == (lhs: MovieListCoordinator, rhs: MovieListCoordinator) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
}
