//
//  TVEpisodeListCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.05.2021.
//

import UIKit

class TVEpisodeListCoordinator:  NavigationCoordinator {
    
//    MARK: - Properties
    var identifier = UUID()
    var childCoordinators = [UUID : Coordinator]()
    var parentCoordinator: Coordinator?
    
    let navigationController: UINavigationController
    
//    MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
//    MARK: - Methods
    func start() {
        
    }
    
    func toDetail(with detailID: String, params: [String : String]) {
        (_, _, _) = factory(with: detailID, vmType: TVEpisodeDetailViewModel.self, vcType: TVEpisodeDetailViewController.self, params: params)
    }
    
}

//  MARK: - extension ToPeopleRoutable
extension TVEpisodeListCoordinator: ToPeopleRoutable { }

//  MARK: - extension ToImageFullScreenRoutable
extension TVEpisodeListCoordinator: ToImageFullScreenRoutable { }

