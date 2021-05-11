//
//  MovieListCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.03.2021.
//

import UIKit

class MovieListCoordinator: NavigationCoordinator {
    
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
        (_, _, _) = factory(with: detailID, vmType: MovieDetailViewModel.self, vcType: MovieDetailViewController.self)
    }
    
    func toTrailerList(with detailID: String, params: [String: String]) {
        (_, _, _) = factory(with: detailID, vmType: MediaTrailerListViewModel.self, vcType: MediaTrailerListViewController.self, params: params)
    }
}

//  MARK: - extension Equatable
extension MovieListCoordinator : Equatable {
    
    static func == (lhs: MovieListCoordinator, rhs: MovieListCoordinator) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

//  MARK: - extension ToPeopleRoutable
extension MovieListCoordinator: ToPeopleRoutable { }

//  MARK: - extension ToImageFullScreenRoutable
extension MovieListCoordinator: ToImageFullScreenRoutable { }
