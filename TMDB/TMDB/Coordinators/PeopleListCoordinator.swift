//
//  PeopleListCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.04.2021.
//

import UIKit

class PeopleListCoordinator: NavigationCoordinator {
    
//    MARK: - Properties
    var navigationController: UINavigationController
    var identifier = UUID()
    var childCoordinators = [UUID : Coordinator]()
    var parentCoordinator: Coordinator?
    
    
//    MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
//    MARK: - Methods
    func start() {
        
    }
    
    func toDetail(with detailID: String) {
        (_, _, _) = factory(with: detailID, vmType: PeopleDetailViewModel.self, vcType: PeopleDetailViewController.self)
    }
    
    
    
    
    
    
}
