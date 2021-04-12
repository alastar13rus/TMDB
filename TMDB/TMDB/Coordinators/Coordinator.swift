//
//  Coordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.03.2021.
//

import UIKit

protocol Coordinator: class {
    
    var identifier: UUID { get }
    var childCoordinators: [UUID: Coordinator] { get set }
    var parentCoordinator: Coordinator? { get set }
    
    func store(_ coordinator: Coordinator)
    func free(_ coordinator: Coordinator)
    func coordinate(to coordinator: Coordinator)
    func start()
}

extension Coordinator {
    
    func store(_ coordinator: Coordinator) {
        childCoordinators[coordinator.identifier] = coordinator
    }
    
    func free(_ coordinator: Coordinator) {
        childCoordinators[coordinator.identifier] = nil
    }
    
    func coordinate(to coordinator: Coordinator) {
        store(coordinator)
        coordinator.start()
    }
}

protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get }
}

extension NavigationCoordinator {
    
    func factory<M: GeneralViewModelType, C: BindableType & UIViewController>(vmType: M.Type, vcType: C.Type) -> (coordinator: Self, viewModel: M, viewController: C) {
        
        let networkManager: NetworkManagerProtocol = NetworkManager()
        
        let viewController = C()
        let viewModel = M(networkManager: networkManager)
        viewModel.coordinator = self
        viewController.bindViewModel(to: viewModel as! C.ViewModelType)
        if (self.navigationController.viewControllers.isEmpty) {
            self.navigationController.pushViewController(viewController, animated: true)
        }
        return (self, viewModel, viewController)
    }
    
    func factory<M: DetailViewModelType, C: BindableType & UIViewController>(with detailID: String, vmType: M.Type, vcType: C.Type) -> (coordinator: Self, viewModel: M, viewController: C) {
        
        let networkManager: NetworkManagerProtocol = NetworkManager()
        
        let viewController = C()
        let viewModel = M(with: detailID, networkManager: networkManager)
        viewModel.coordinator = self
        viewController.bindViewModel(to: viewModel as! C.ViewModelType)
        self.navigationController.pushViewController(viewController, animated: true)
        return (self, viewModel, viewController)
    }
    
}
