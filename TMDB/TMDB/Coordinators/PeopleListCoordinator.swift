//
//  PeopleListCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.04.2021.
//

import UIKit

class PeopleListCoordinator: NavigationCoordinator {
    
//    MARK: - Properties
    var navigationController: UINavigationController
    var identifier = UUID()
    var childCoordinators = [UUID : Coordinator]()
    var parentCoordinator: Coordinator?
    
    
//    MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
//    MARK: - Methods
    func start() {
        
    }
    
    func toDetail(with detailID: String) {
        (_, _, _) = factory(with: detailID, vmType: PeopleDetailViewModel.self, vcType: PeopleDetailViewController.self)
    }
        
    func toMovieDetail(with detailID: String) {
        
        guard let movieListCoordinator = parentCoordinator as? MovieListCoordinator else {
            let movieListCoordinator = MovieListCoordinator(navigationController: navigationController)
            store(movieListCoordinator)
            movieListCoordinator.toDetail(with: detailID)
            return
        }
        movieListCoordinator.toDetail(with: detailID)
        
    }
    
    func toTVDetail(with detailID: String) {

        guard let tvListCoordinator = parentCoordinator as? TVListCoordinator else {
            let tvListCoordinator = TVListCoordinator(navigationController: navigationController)
            store(tvListCoordinator)
            tvListCoordinator.toDetail(with: detailID)
            return
        }
        tvListCoordinator.toDetail(with: detailID)
    }
    
    func toImageFullScreen(withImageCellViewModel imageCellViewModel: ImageCellViewModel, contentForm: ContentForm) {
        let fullScreenViewController = FullScreenViewController()
        let fullScreenViewModel = FullScreenViewModel(withImageCellViewModel: imageCellViewModel, contentForm: contentForm)
        fullScreenViewModel.coordinator = self
        fullScreenViewController.viewModel = fullScreenViewModel
        
        navigationController.present(fullScreenViewController, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}
