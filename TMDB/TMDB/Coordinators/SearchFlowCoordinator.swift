//
//  SearchFlowCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 25.05.2021.
//

import UIKit
import Domain
import Swinject

class SearchFlowCoordinator: NavigationCoordinator {
    
// MARK: - Properties
    var container: Container
    var navigationController: UINavigationController
    var identifier = UUID()
    var childCoordinators = [UUID: Coordinator]()
    var parentCoordinator: Coordinator?
    
// MARK: - Init
    init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
// MARK: - Methods
    func start() {
        _ = container.resolve(Typealias.SearchBundle.self, argument: self)
    }
    
    func showFilterOptionListMedia(type: Domain.SearchCategory) {
        _ = container.resolve(Typealias.FilterOptionListMediaBundle.self, arguments: self, type)
    }
    
    func toMediaListByYear(_ year: String, mediaType: Domain.MediaType) {
        _ = container.resolve(Typealias.MediaListByYearBundle.self, arguments: self, mediaType, MediaFilterType.byYear(year: year))
    }
    
    func toMediaListByGenre(_ genreID: String, genreName: String, mediaType: Domain.MediaType) {
        _ = container.resolve(Typealias.MediaFilteredListBundle.self,
                              arguments: self, mediaType, MediaFilterType.byGenre(genreID: genreID, genreName: genreName))
    }
    
    func toMovie(with mediaID: String) {
        guard let movieFlowCoordinator = parentCoordinator as? MovieFlowCoordinator else {
            let movieFlowCoordinator = MovieFlowCoordinator(navigationController: navigationController, container: container)
            store(movieFlowCoordinator)
            movieFlowCoordinator.toDetail(with: mediaID)
            return
        }
        
        movieFlowCoordinator.toDetail(with: mediaID)
    }
    
    func toTV(with mediaID: String) {
        guard let tvFlowCoordinator = parentCoordinator as? TVFlowCoordinator else {
            let tvFlowCoordinator = TVFlowCoordinator(navigationController: navigationController, container: container)
            store(tvFlowCoordinator)
            tvFlowCoordinator.toDetail(with: mediaID)
            return
        }
        
        tvFlowCoordinator.toDetail(with: mediaID)
    }
}

extension SearchFlowCoordinator: ToPeopleRoutable { }
