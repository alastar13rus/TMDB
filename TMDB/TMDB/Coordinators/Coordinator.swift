//
//  Coordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.03.2021.
//

import UIKit
import Swinject
import Domain

protocol Coordinator: AnyObject {
    
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
        coordinator.parentCoordinator = self
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
    var container: Container { get }
    var navigationController: UINavigationController { get }
}
