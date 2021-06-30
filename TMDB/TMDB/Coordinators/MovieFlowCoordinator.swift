//
//  MovieFlowCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.03.2021.
//

import UIKit
import Swinject
import Domain

class MovieFlowCoordinator: NavigationCoordinator {
    
    typealias MediaListBundle = (vc: MediaListViewController,
                                 vm: MediaListViewModel,
                                 c: MovieFlowCoordinator)
    
    typealias MovieDetailBundle = (vc: MovieDetailViewController,
                                   vm: MovieDetailViewModel,
                                   c: MovieFlowCoordinator)
    
    typealias MediaTrailerListBundle = (vc: MediaTrailerListViewController,
                                        vm: MediaTrailerListViewModel,
                                        c: MovieFlowCoordinator)
    
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
    func start() {
        _ = container.resolve(Typealias.MediaListBundle.self, argument: (self as NavigationCoordinator))
    }
    
    func toDetail(with detailID: String) {
        _ = container.resolve(Typealias.MovieDetailBundle.self, arguments: self, detailID)
    }
    
    func toTrailerList(with mediaID: String, mediaType: MediaType) {
        _ = container.resolve(Typealias.MediaTrailerListBundle.self, arguments: (self as NavigationCoordinator), mediaID, mediaType)
    }
}

// MARK: - extension Equatable
extension MovieFlowCoordinator: Equatable {
    
    static func == (lhs: MovieFlowCoordinator, rhs: MovieFlowCoordinator) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

// MARK: - extension ToPeopleRoutable
extension MovieFlowCoordinator: ToPeopleRoutable { }

// MARK: - extension ToImageFullScreenRoutable
extension MovieFlowCoordinator: ToImageFullScreenRoutable { }

extension MovieFlowCoordinator: Alertable {  }
