//
//  TVListCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 05.04.2021.
//

import UIKit

class TVListCoordinator:  NavigationCoordinator {
    
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
        (_, _, _) = factory(with: detailID, vmType: TVDetailViewModel.self, vcType: TVDetailViewController.self)
    }
    
    func toCreditList(with detailID: String, params: [String: String]) {
        (_, _, _) = factory(with: detailID, vmType: CreditListViewModel.self, vcType: CreditListViewController.self, params: params)
    }
    
    func toPeople(with peopleID: String) {
        let peopleListCoordinator = PeopleListCoordinator(navigationController: navigationController)
        peopleListCoordinator.toDetail(with: peopleID)
    }
    
}
