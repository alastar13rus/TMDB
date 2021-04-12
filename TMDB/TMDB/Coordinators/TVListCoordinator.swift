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
    
}
