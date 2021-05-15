//
//  TVFlowCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 05.04.2021.
//

import UIKit
import Swinject

class TVFlowCoordinator:  NavigationCoordinator {
    
//    MARK: - Properties
    var identifier = UUID()
    var childCoordinators = [UUID : Coordinator]()
    var parentCoordinator: Coordinator?
    
    let navigationController: UINavigationController
    let container: Container
    
//    MARK: - Init
    init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
//    MARK: - Methods
    func start() {
        _ = container.resolve(MediaListViewModel.self, argument: (self as NavigationCoordinator))
    }
    
    func toDetail(with detailID: String) {
        _ = container.resolve(TVDetailViewModel.self, arguments: self, detailID)
    }
    
    func toTrailerList(with mediaID: String, mediaType: MediaType) {
        _ = container.resolve(MediaTrailerListViewModel.self, arguments: (self as NavigationCoordinator), mediaID, mediaType)
    }
    
    func toSeasonList(with mediaID: String) {
        guard let tvSeasonFlowCoordinator = parentCoordinator as? TVSeasonFlowCoordinator else {
            let tvSeasonFlowCoordinator = TVSeasonFlowCoordinator(navigationController: navigationController, container: container)
            store(tvSeasonFlowCoordinator)
            tvSeasonFlowCoordinator.start(with: mediaID)
            return
        }
        tvSeasonFlowCoordinator.start(with: mediaID)
    }
    
    
    func toSeason(with mediaID: String, seasonNumber: String) {
        guard let tvSeasonFlowCoordinator = parentCoordinator as? TVSeasonFlowCoordinator else {
            let tvSeasonFlowCoordinator = TVSeasonFlowCoordinator(navigationController: navigationController, container: container)
            store(tvSeasonFlowCoordinator)
            tvSeasonFlowCoordinator.toDetail(with: mediaID, seasonNumber: seasonNumber)
            return
        }
        tvSeasonFlowCoordinator.toDetail(with: mediaID, seasonNumber: seasonNumber)
    }
}

//  MARK: - extension ToPeopleRoutable
extension TVFlowCoordinator: ToPeopleRoutable { }

//  MARK: - extension ToPeopleRoutable
extension TVFlowCoordinator: ToSeasonRoutable { }

//  MARK: - extension ToImageFullScreenRoutable
extension TVFlowCoordinator: ToImageFullScreenRoutable { }
