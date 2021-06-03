//
//  TVEpisodeFlowCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.05.2021.
//

import UIKit
import Swinject
import Domain

class TVEpisodeFlowCoordinator:  NavigationCoordinator {
    
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
        
    }
    
    func start(with mediaID: String, seasonNumber: String) {
        _ = container.resolve(Typealias.TVEpisodeListBundle.self, arguments: self, mediaID, seasonNumber)
    }
    
    func toDetail(with mediaID: String, seasonNumber: String, episodeNumber: String) {
        _ = container.resolve(Typealias.TVEpisodeDetailBundle.self, arguments: self, mediaID, seasonNumber, episodeNumber)
    }
    
    func toTrailerList(with mediaID: String, mediaType: MediaType, seasonNumber: String, episodeNumber: String) {
        _ = container.resolve(Typealias.MediaTrailerListBundle.self, arguments: (self as NavigationCoordinator), mediaID, seasonNumber, episodeNumber)
    }
    
}

//  MARK: - extension ToPeopleRoutable
extension TVEpisodeFlowCoordinator: ToPeopleRoutable { }

//  MARK: - extension ToImageFullScreenRoutable
extension TVEpisodeFlowCoordinator: ToImageFullScreenRoutable { }

