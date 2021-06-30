//
//  TVSeasonFlowCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 04.05.2021.
//

import UIKit
import Swinject
import Domain

protocol ToSeasonRoutable: NavigationCoordinator {
    func toSeason(with mediaID: String, seasonNumber: String)
    func toSeasonList(with mediaID: String)
}

extension ToSeasonRoutable {
    
    func toSeason(with mediaID: String, seasonNumber: String) {
        guard let tvSeasonFlowCoordinator = parentCoordinator as? TVSeasonFlowCoordinator else {
            let tvSeasonFlowCoordinator = TVSeasonFlowCoordinator(navigationController: navigationController, container: container)
            store(tvSeasonFlowCoordinator)
            tvSeasonFlowCoordinator.toDetail(with: mediaID, seasonNumber: seasonNumber)
            return
        }
        
        tvSeasonFlowCoordinator.toDetail(with: mediaID, seasonNumber: seasonNumber)
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
}

class TVSeasonFlowCoordinator: NavigationCoordinator {
    
// MARK: - Properties
    var identifier = UUID()
    var childCoordinators = [UUID: Coordinator]()
    var parentCoordinator: Coordinator?
    
    let navigationController: UINavigationController
    let container: Container
    
// MARK: - Init
    init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
// MARK: - Methods
    func start() { }
    
    func start(with mediaID: String) {
        _ = container.resolve(Typealias.TVSeasonListBundle.self, arguments: self, mediaID)
    }
    
    func toDetail(with mediaID: String, seasonNumber: String) {
        _ = container.resolve(Typealias.TVSeasonDetailBundle.self, arguments: self, mediaID, seasonNumber)
    }
    
    func toTrailerList(with mediaID: String, mediaType: MediaType, seasonNumber: String) {
        _ = container.resolve(Typealias.MediaTrailerListBundle.self, arguments: (self as NavigationCoordinator), mediaID, mediaType, seasonNumber)
    }
    
    func toEpisodeList(with mediaID: String, seasonNumber: String) {
        guard let tvEpisodeFlowCoordinator = parentCoordinator as? TVEpisodeFlowCoordinator else {
            let tvEpisodeFlowCoordinator = TVEpisodeFlowCoordinator(navigationController: navigationController, container: container)
            store(tvEpisodeFlowCoordinator)
            tvEpisodeFlowCoordinator.start(with: mediaID, seasonNumber: seasonNumber)
            return
        }
        tvEpisodeFlowCoordinator.start(with: mediaID, seasonNumber: seasonNumber)
    }
    
    func toEpisode(with mediaID: String, seasonNumber: String, episodeNumber: String) {
        guard let tvEpisodeFlowCoordinator = parentCoordinator as? TVEpisodeFlowCoordinator else {
            let tvEpisodeFlowCoordinator = TVEpisodeFlowCoordinator(navigationController: navigationController, container: container)
            store(tvEpisodeFlowCoordinator)
            tvEpisodeFlowCoordinator.toDetail(with: mediaID, seasonNumber: seasonNumber, episodeNumber: episodeNumber)
            return
        }
        tvEpisodeFlowCoordinator.toDetail(with: mediaID, seasonNumber: seasonNumber, episodeNumber: episodeNumber)
    }
}

// MARK: - extension ToPeopleRoutable
extension TVSeasonFlowCoordinator: ToPeopleRoutable { }

// MARK: - extension ToImageFullScreenRoutable
extension TVSeasonFlowCoordinator: ToImageFullScreenRoutable { }
