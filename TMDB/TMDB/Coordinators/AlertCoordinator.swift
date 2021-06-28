//
//  AlertCoordinator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 14.06.2021.
//

import UIKit
import Swinject
import Domain
import NetworkPlatform

protocol Alertable: NavigationCoordinator {
    
    func getAlertCoordinator(title: String, message: String) -> AlertCoordinator
    func showAlert(title: String, message: String)
}

extension Alertable {
    func getAlertCoordinator(title: String, message: String) -> AlertCoordinator {
        return AlertCoordinator()
    }
    
    func showAlert(title: String, message: String) {
//        let alertCoordinator = AlertCoordinator()
//        alertCoordinator.setAlertTitle(title)
//        alertCoordinator.setAlertMessage(message)
//        alertCoordinator.start()
    }
}

class AlertCoordinator: Coordinator {
    
//    MARK: - Properties
    var identifier = UUID()
    var childCoordinators = [UUID : Coordinator]()
    var parentCoordinator: Coordinator?
    
    private var message: String = ""
    private var title: String = ""
    
    
//    MARK: - Methods
    func start() {
        let alertController = UIAlertController(title: "Информация", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(alertAction)
        var rootViewController = UIApplication.shared.windows.first!.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }

        guard rootViewController?.presentingViewController is UIAlertController else {
            rootViewController?.dismiss(animated: true, completion: {
                rootViewController?.present(alertController, animated: true, completion: nil)
            })
            return
        }
        
        rootViewController?.present(alertController, animated: true, completion: nil)
        
    }
    
}

extension AlertCoordinator: NetworkMonitorDelegate {
    func didChangeStatus(_ isConnected: Bool) {
        self.message = isConnected ? "Сетевое соединение активно" : "Сетевое соединение отсутствует"
        self.start()
    }
    
    func inform(with message: String) {
        self.message = message
        self.start()
    }
}
