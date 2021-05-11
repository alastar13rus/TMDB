//
//  TVSeasonListCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 04.05.2021.
//

import UIKit

class TVSeasonListCoordinator:  NavigationCoordinator {
    
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
        (_, _, _) = factory(with: detailID, vmType: TVSeasonDetailViewModel.self, vcType: TVSeasonDetailViewController.self, params: params)
    }
    
    func toEpisodeList(with detailID: String, params: [String : String]) {
        (_, _, _) = factory(with: detailID, vmType: TVEpisodeListViewModel.self, vcType: TVEpisodeListViewController.self, params: params)
    }
    
    func toEpisode(with episodeNumber: String, params: [String: String]) {
        guard let tvEpisodeListCoordinator = parentCoordinator as? TVEpisodeListCoordinator else {
            let tvEpisodeListCoordinator = TVEpisodeListCoordinator(navigationController: navigationController)
            store(tvEpisodeListCoordinator)
            tvEpisodeListCoordinator.toDetail(with: episodeNumber, params: params)
            return
        }
        tvEpisodeListCoordinator.toDetail(with: episodeNumber, params: params)
    }
}

//  MARK: - extension ToPeopleRoutable
extension TVSeasonListCoordinator: ToPeopleRoutable { }


//  MARK: - extension ToImageFullScreenRoutable
extension TVSeasonListCoordinator: ToImageFullScreenRoutable { }
