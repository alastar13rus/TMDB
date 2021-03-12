//
//  Coordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.03.2021.
//

import Foundation

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
