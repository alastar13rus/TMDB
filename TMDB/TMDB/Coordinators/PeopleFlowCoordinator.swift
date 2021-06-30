//
//  PeopleFlowCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.04.2021.
//

import UIKit
import Swinject
import Domain

protocol ToPeopleRoutable: NavigationCoordinator {
    func toPeople(with: String)
    func toCreditList(with mediaID: String, mediaType: MediaType, creditType: CreditType, seasonNumber: String?, episodeNumber: String?)
}

extension ToPeopleRoutable {
    
    func toPeople(with peopleID: String) {
        guard let peopleFlowCoordinator = parentCoordinator as? PeopleFlowCoordinator else {
            let peopleFlowCoordinator = PeopleFlowCoordinator(navigationController: navigationController, container: container)
            store(peopleFlowCoordinator)
            peopleFlowCoordinator.toDetail(with: peopleID)
            return
        }
        
        peopleFlowCoordinator.toDetail(with: peopleID)
    }
    
    func toCreditList(with mediaID: String, mediaType: MediaType, creditType: CreditType, seasonNumber: String?, episodeNumber: String?) {
        _ = container.resolve(Typealias.CreditListBundle.self,
                              arguments: (self as NavigationCoordinator), mediaID, mediaType, creditType, seasonNumber, episodeNumber)
    }
}

protocol ToImageFullScreenRoutable: NavigationCoordinator {
    func toImageFullScreen(withImageCellViewModel imageCellViewModel: ImageCellViewModel, contentForm: ContentForm)
}

extension ToImageFullScreenRoutable {
    
    func toImageFullScreen(withImageCellViewModel imageCellViewModel: ImageCellViewModel, contentForm: ContentForm) {
        let fullScreenViewController = FullScreenViewController()
        let fullScreenViewModel = FullScreenViewModel(withImageCellViewModel: imageCellViewModel, contentForm: contentForm)
        fullScreenViewModel.coordinator = self
        fullScreenViewController.viewModel = fullScreenViewModel
        
        navigationController.present(fullScreenViewController, animated: true, completion: nil)
    }
}

class PeopleFlowCoordinator: NavigationCoordinator {
    
// MARK: - Properties
    var navigationController: UINavigationController
    var identifier = UUID()
    var childCoordinators = [UUID: Coordinator]()
    var parentCoordinator: Coordinator?
    let container: Container
    
// MARK: - Init
    init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
// MARK: - Methods
    func start() {
        
    }
    
    func toDetail(with mediaID: String) {
        _ = container.resolve(Typealias.PeopleDetailBundle.self, arguments: self, mediaID)
    }
        
    func toMovieDetail(with mediaID: String) {
        
        guard let movieFlowCoordinator = parentCoordinator as? MovieFlowCoordinator else {
            let movieFlowCoordinator = MovieFlowCoordinator(navigationController: navigationController, container: container)
            store(movieFlowCoordinator)
            movieFlowCoordinator.toDetail(with: mediaID)
            return
        }
        movieFlowCoordinator.toDetail(with: mediaID)
        
    }
    
    func toTVDetail(with mediaID: String) {

        guard let tvFlowCoordinator = parentCoordinator as? TVFlowCoordinator else {
            let tvFlowCoordinator = TVFlowCoordinator(navigationController: navigationController, container: container)
            store(tvFlowCoordinator)
            tvFlowCoordinator.toDetail(with: mediaID)
            return
        }
        tvFlowCoordinator.toDetail(with: mediaID)
    }
}

// MARK: - extension ToImageFullScreenRoutable
extension PeopleFlowCoordinator: ToImageFullScreenRoutable { }
