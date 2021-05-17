//
//  AppDIContainer.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 13.05.2021.
//

import Foundation
import Swinject
import Domain

class AppDIContainer {
    static let shared: Container = {
        let container = Container()
        setupDI(container)

        return container
    }()
    
    private init() {  }
    
    fileprivate static func setupDI(_ container: Container) {
        
        container.register(NetworkManagerProtocol.self) { _ in NetworkManager() }
        
//        MARK: - ViewControllers
        
        container.register(MovieDetailViewController.self) { _ in MovieDetailViewController() }
        container.register(TVDetailViewController.self) { _ in TVDetailViewController() }
        
        container.register(TVSeasonListViewController.self) { _ in TVSeasonListViewController() }
        container.register(TVSeasonDetailViewController.self) { _ in TVSeasonDetailViewController() }
        
        container.register(TVEpisodeListViewController.self) { _ in TVEpisodeListViewController() }
        container.register(TVEpisodeDetailViewController.self) { _ in TVEpisodeDetailViewController() }
        
        container.register(PeopleDetailViewController.self) { _ in PeopleDetailViewController() }
        
        container.register(CreditListViewController.self) { _ in CreditListViewController() }
        container.register(MediaTrailerListViewController.self) { _ in MediaTrailerListViewController() }
        container.register(FullScreenViewController.self) { _ in FullScreenViewController() }
        
//        MARK: - ViewModels
        
        
        container.register(MediaListViewModel.self) { (r, coordinator: NavigationCoordinator) in
            let viewController = MediaListViewController()
            
            let viewModel = MediaListViewModel(networkManager: r.resolve(NetworkManagerProtocol.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            if (coordinator.navigationController.viewControllers.isEmpty) {
                coordinator.navigationController.pushViewController(viewController, animated: true)
            }
            return viewModel
        }
        
        container.register(MovieDetailViewModel.self)  { (r, coordinator: MovieFlowCoordinator, detailID: String) in
            let viewController = MovieDetailViewController()
            
            let viewModel = MovieDetailViewModel(with: detailID, networkManager: r.resolve(NetworkManagerProtocol.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            return viewModel
        }
        
        container.register(TVDetailViewModel.self)  { (r, coordinator: TVFlowCoordinator, detailID: String) in
            let viewController = TVDetailViewController()
            
            let viewModel = TVDetailViewModel(with: detailID, networkManager: r.resolve(NetworkManagerProtocol.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            return viewModel
        }
        
        container.register(TVSeasonListViewModel.self)  { (r, coordinator: TVSeasonFlowCoordinator, mediaID: String) in
            let viewController = TVSeasonListViewController()
            
            let viewModel = TVSeasonListViewModel(with: mediaID, networkManager: r.resolve(NetworkManagerProtocol.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            return viewModel
        }
        
        container.register(TVEpisodeListViewModel.self)  { (r, coordinator: TVEpisodeFlowCoordinator, mediaID: String, seasonNumber: String) in
            let viewController = TVEpisodeListViewController()
            
            let viewModel = TVEpisodeListViewModel(with: mediaID, seasonNumber: seasonNumber, networkManager: r.resolve(NetworkManagerProtocol.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            return viewModel
        }
        
        container.register(TVSeasonDetailViewModel.self)  { (r, coordinator: TVSeasonFlowCoordinator, mediaID: String, seasonNumber: String) in
            let viewController = TVSeasonDetailViewController()
            
            let viewModel = TVSeasonDetailViewModel(with: mediaID, seasonNumber: seasonNumber, networkManager: r.resolve(NetworkManagerProtocol.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            return viewModel
        }
        
        container.register(TVEpisodeDetailViewModel.self)  { (r, coordinator: TVEpisodeFlowCoordinator, mediaID: String, seasonNumber: String, episodeNumber: String) in
            let viewController = TVEpisodeDetailViewController()
            
            let viewModel = TVEpisodeDetailViewModel(with: mediaID, seasonNumber: seasonNumber, episodeNumber: episodeNumber, networkManager: r.resolve(NetworkManagerProtocol.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            return viewModel
        }
        
        container.register(MediaTrailerListViewModel.self)  { (r, coordinator: NavigationCoordinator, mediaID: String, mediaType: MediaType) in
            let viewController = MediaTrailerListViewController()
            
            let viewModel = MediaTrailerListViewModel(with: mediaID, mediaType: mediaType, networkManager: r.resolve(NetworkManagerProtocol.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            return viewModel
        }
        
        container.register(MediaTrailerListViewModel.self)  { (r, coordinator: NavigationCoordinator, mediaID: String, mediaType: MediaType, seasonNumber: String) in
            let viewController = MediaTrailerListViewController()
            
            let viewModel = MediaTrailerListViewModel(with: mediaID, mediaType: mediaType, seasonNumber: seasonNumber, networkManager: r.resolve(NetworkManagerProtocol.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            return viewModel
        }
        
        container.register(MediaTrailerListViewModel.self)  { (r, coordinator: NavigationCoordinator, mediaID: String, mediaType: MediaType, seasonNumber: String, episodeNumber: String) in
            let viewController = MediaTrailerListViewController()
            
            let viewModel = MediaTrailerListViewModel(with: mediaID, mediaType: mediaType, seasonNumber: seasonNumber, episodeNumber: episodeNumber, networkManager: r.resolve(NetworkManagerProtocol.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            return viewModel
        }
        
        container.register(CreditListViewModel.self)  { (r, coordinator: NavigationCoordinator, mediaID: String, mediaType: MediaType, creditType: CreditType, seasonNumber: String?, episodeNumber: String?) in
            let viewController = CreditListViewController()
            
            let viewModel = CreditListViewModel(with: mediaID, mediaType: mediaType, creditType: creditType, seasonNumber: seasonNumber, episodeNumber: episodeNumber, networkManager: r.resolve(NetworkManagerProtocol.self)!)
            viewModel.coordinator = coordinator  as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            return viewModel
        }
        
        container.register(PeopleDetailViewModel.self)  { (r, coordinator: PeopleFlowCoordinator, mediaID: String) in
            let viewController = PeopleDetailViewController()
            
            let viewModel = PeopleDetailViewModel(with: mediaID, networkManager: r.resolve(NetworkManagerProtocol.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            return viewModel
        }
        
        
    }
        
}
