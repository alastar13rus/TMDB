//
//  TVListCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 05.04.2021.
//

import UIKit

class TVListCoordinator:  NavigationCoordinator {
    
    var identifier = UUID()
    var childCoordinators = [UUID : Coordinator]()
    var parentCoordinator: Coordinator?
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        (_, _, _) = factory(vmType: MediaListViewModel.self, vcType: MediaListViewController.self)
    }
    
    func toDetail(with detailID: String) {
        (_, _, _) = factory(with: detailID, vmType: TVDetailViewModel.self, vcType: TVDetailViewController.self)
    }
    
    func toCreditList(with detailID: String, params: [String: String]) {
        (_, _, _) = factory(with: detailID, vmType: CreditListViewModel.self, vcType: CreditListViewController.self, params: params)
    }
    
    func toPeople(with peopleID: String) {
        guard let peopleListCoordinator = parentCoordinator as? PeopleListCoordinator else {
            let peopleListCoordinator = PeopleListCoordinator(navigationController: navigationController)
            store(peopleListCoordinator)
            peopleListCoordinator.toDetail(with: peopleID)
            return
        }
        peopleListCoordinator.toDetail(with: peopleID)
    }
    
    func toImageFullScreen(withImageCellViewModel imageCellViewModel: ImageCellViewModel, contentForm: ContentForm) {
        let fullScreenViewController = FullScreenViewController()
        let fullScreenViewModel = FullScreenViewModel(withImageCellViewModel: imageCellViewModel, contentForm: contentForm)
        fullScreenViewModel.coordinator = self
        fullScreenViewController.viewModel = fullScreenViewModel
        
        navigationController.present(fullScreenViewController, animated: true, completion: nil)
    }
    
}
