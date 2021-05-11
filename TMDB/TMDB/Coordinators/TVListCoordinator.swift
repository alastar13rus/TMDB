//
//  TVListCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 05.04.2021.
//

import UIKit

class TVListCoordinator:  NavigationCoordinator {
    
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
        (_, _, _) = factory(vmType: MediaListViewModel.self, vcType: MediaListViewController.self)
    }
    
    func toDetail(with detailID: String) {
        (_, _, _) = factory(with: detailID, vmType: TVDetailViewModel.self, vcType: TVDetailViewController.self)
    }
    
    func toTrailerList(with detailID: String, params: [String: String]) {
        (_, _, _) = factory(with: detailID, vmType: MediaTrailerListViewModel.self, vcType: MediaTrailerListViewController.self, params: params)
    }
    
    func toSeasonList(with detailID: String) {
        (_, _, _) = factory(with: detailID, vmType: TVSeasonListViewModel.self, vcType: TVSeasonListViewController.self)
    }
    
    
    func toSeason(with seasonNumber: String, params: [String: String]) {
        guard let tvSeasonListCoordinator = parentCoordinator as? TVSeasonListCoordinator else {
            let tvSeasonListCoordinator = TVSeasonListCoordinator(navigationController: navigationController)
            store(tvSeasonListCoordinator)
            tvSeasonListCoordinator.toDetail(with: seasonNumber, params: params)
            return
        }
        tvSeasonListCoordinator.toDetail(with: seasonNumber, params: params)
    }
}

//  MARK: - extension ToPeopleRoutable
extension TVListCoordinator: ToPeopleRoutable { }

//  MARK: - extension ToImageFullScreenRoutable
extension TVListCoordinator: ToImageFullScreenRoutable { }
