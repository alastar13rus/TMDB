//
//  AppDIContainer.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 13.05.2021.
//

import Foundation
import Swinject
import Domain
import NetworkPlatform
import CoreDataPlatform

class AppDIContainer {
    static let shared: Container = {
        let container = Container()
        setupDI(container)

        return container
    }()
    
    private init() {  }
    
    fileprivate static func setupDI(_ container: Container) {
        
//        MARK: - NetworkPlatform
        container.register(NetworkPlatform.NetworkAgent.self) { _ in
            return NetworkAgent()
        }
        
        container.register(NetworkPlatform.NetworkProvider.self) { r in NetworkPlatform.NetworkProvider(network: r.resolve(NetworkPlatform.NetworkAgent.self)!) }
        
//        MARK: - CoreDataPlatform
        
        container.register(CoreDataPlatform.CoreDataAgent.self) { _ in
            let coreDataStack = container.resolve(CoreDataStack.self)!
            return CoreDataAgent(with: coreDataStack.viewContext)
        }
        
        container.register(CoreDataPlatform.CoreDataProvider.self) { r in CoreDataPlatform.CoreDataProvider(coreData: r.resolve(CoreDataPlatform.CoreDataAgent.self)!) }
        
        container.register(CoreDataPlatform.CoreDataStack.self) { r in
            return CoreDataPlatform.CoreDataStack.shared
            
        }
        
//        MARK: - Domain
        
        container.register(Domain.APIFactory.self) { r in
            let appConfig = AppConfig()
            let config = (apiKey: appConfig.apiKey, apiBaseURL: appConfig.apiBaseURL)
            return NetworkPlatform.APIFactory(config)
            
        }
        
        container.register(Domain.UseCaseProvider.self) { r in
            NetworkPlatform.UseCaseProvider(
                networkProvider: r.resolve(NetworkPlatform.NetworkProvider.self)!,
                apiFactory: r.resolve(Domain.APIFactory.self)!) }
        
        container.register(Domain.UseCasePersistenceProvider.self) { r in
            CoreDataPlatform.UseCasePersistenceProvider(
                dbProvider: r.resolve(CoreDataPlatform.CoreDataProvider.self)!) }
        
        
        registerVC(with: container)
        
        registerVM(with: container)
        
        registerBundles(with: container)
        
    }
    
    fileprivate static func registerVC(with container: Container) {
        
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
    }
    
    fileprivate static func registerVM(with container: Container) {
        
        container.register(MediaListViewModel.self) { r in
            return MediaListViewModel(useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
        }
        
        container.register(MovieDetailViewModel.self)  { (r, detailID: String) in
            return MovieDetailViewModel(with: detailID, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!, useCasePersistenceProvider: r.resolve(Domain.UseCasePersistenceProvider.self)!)
        }
        
        container.register(TVDetailViewModel.self)  { (r, detailID: String) in
            return TVDetailViewModel(with: detailID, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!, useCasePersistenceProvider: r.resolve(Domain.UseCasePersistenceProvider.self)!)
        }
        
        container.register(TVSeasonListViewModel.self)  { (r, mediaID: String) in
            return TVSeasonListViewModel(with: mediaID, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
        }
        
        container.register(TVEpisodeListViewModel.self)  { (r, mediaID: String, seasonNumber: String) in
            return TVEpisodeListViewModel(with: mediaID, seasonNumber: seasonNumber, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
        }
        
        container.register(TVSeasonDetailViewModel.self)  { (r, mediaID: String, seasonNumber: String) in
            return TVSeasonDetailViewModel(with: mediaID, seasonNumber: seasonNumber, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
        }
        
        container.register(TVEpisodeDetailViewModel.self)  { (r, mediaID: String, seasonNumber: String, episodeNumber: String) in
            return TVEpisodeDetailViewModel(with: mediaID, seasonNumber: seasonNumber, episodeNumber: episodeNumber, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
        }
        
        container.register(MediaTrailerListViewModel.self)  { (r, mediaID: String, mediaType: MediaType) in
            return MediaTrailerListViewModel(with: mediaID, mediaType: mediaType, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
        }
        
        container.register(MediaTrailerListViewModel.self)  { (r, mediaID: String, mediaType: MediaType, seasonNumber: String) in
            return MediaTrailerListViewModel(with: mediaID, mediaType: mediaType, seasonNumber: seasonNumber, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
        }
        
        container.register(MediaTrailerListViewModel.self)  { (r, mediaID: String, mediaType: MediaType, seasonNumber: String, episodeNumber: String) in
            return MediaTrailerListViewModel(with: mediaID, mediaType: mediaType, seasonNumber: seasonNumber, episodeNumber: episodeNumber, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
        }
        
        container.register(CreditListViewModel.self)  { (r, mediaID: String, mediaType: MediaType, creditType: CreditType, seasonNumber: String?, episodeNumber: String?) in
            return CreditListViewModel(with: mediaID, mediaType: mediaType, creditType: creditType, seasonNumber: seasonNumber, episodeNumber: episodeNumber, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
        }
        
        container.register(PeopleDetailViewModel.self)  { (r, coordinator: PeopleFlowCoordinator, mediaID: String) in
            return PeopleDetailViewModel(with: mediaID, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!, useCasePersistenceProvider: r.resolve(Domain.UseCasePersistenceProvider.self)!)

        }
    }
    
    fileprivate static func registerBundles(with container: Container) {
            
            container.register(Typealias.MediaListBundle.self) { (r, coordinator: NavigationCoordinator) in
                let viewController = MediaListViewController()
                
                let viewModel = MediaListViewModel(useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
                viewModel.coordinator = coordinator as NavigationCoordinator
                viewController.bindViewModel(to: viewModel)
                if (coordinator.navigationController.viewControllers.isEmpty) {
                    coordinator.navigationController.pushViewController(viewController, animated: true)
                }
                return (viewController: viewController, viewModel: viewModel, coordinator: coordinator)
            }
        
        container.register(Typealias.MovieDetailBundle.self)  { (r, coordinator: MovieFlowCoordinator, detailID: String) in
            let viewController = MovieDetailViewController()
            
            let viewModel = MovieDetailViewModel(with: detailID, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!, useCasePersistenceProvider: r.resolve(Domain.UseCasePersistenceProvider.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            
            return (viewController: viewController, viewModel: viewModel, coordinator: coordinator)
        }
        
        container.register(Typealias.TVDetailBundle.self)  { (r, coordinator: TVFlowCoordinator, detailID: String) in
            let viewController = TVDetailViewController()
            
            let viewModel = TVDetailViewModel(with: detailID, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!, useCasePersistenceProvider: r.resolve(Domain.UseCasePersistenceProvider.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            
            return (viewController: viewController, viewModel: viewModel, coordinator: coordinator)
        }
        
        container.register(Typealias.TVSeasonListBundle.self)  { (r, coordinator: TVSeasonFlowCoordinator, mediaID: String) in
            let viewController = TVSeasonListViewController()
            
            let viewModel = TVSeasonListViewModel(with: mediaID, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            
            return (viewController: viewController, viewModel: viewModel, coordinator: coordinator)
        }
        
        container.register(Typealias.TVEpisodeListBundle.self)  { (r, coordinator: TVEpisodeFlowCoordinator, mediaID: String, seasonNumber: String) in
            let viewController = TVEpisodeListViewController()
            
            let viewModel = TVEpisodeListViewModel(with: mediaID, seasonNumber: seasonNumber, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            
            return (viewController: viewController, viewModel: viewModel, coordinator: coordinator)
        }
        
        container.register(Typealias.TVSeasonDetailBundle.self)  { (r, coordinator: TVSeasonFlowCoordinator, mediaID: String, seasonNumber: String) in
            let viewController = TVSeasonDetailViewController()
            
            let viewModel = TVSeasonDetailViewModel(with: mediaID, seasonNumber: seasonNumber, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            
            return (viewController: viewController, viewModel: viewModel, coordinator: coordinator)
        }
        
        container.register(Typealias.TVEpisodeDetailBundle.self)  { (r, coordinator: TVEpisodeFlowCoordinator, mediaID: String, seasonNumber: String, episodeNumber: String) in
            let viewController = TVEpisodeDetailViewController()
            
            let viewModel = TVEpisodeDetailViewModel(with: mediaID, seasonNumber: seasonNumber, episodeNumber: episodeNumber, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            
            return (viewController: viewController, viewModel: viewModel, coordinator: coordinator)
        }
        
        container.register(Typealias.MediaTrailerListBundle.self)  { (r, coordinator: NavigationCoordinator, mediaID: String, mediaType: MediaType) in
            let viewController = MediaTrailerListViewController()
            
            let viewModel = MediaTrailerListViewModel(with: mediaID, mediaType: mediaType, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            
            return (viewController: viewController, viewModel: viewModel, coordinator: coordinator)
        }
        
        container.register(Typealias.MediaTrailerListBundle.self)  { (r, coordinator: NavigationCoordinator, mediaID: String, mediaType: MediaType, seasonNumber: String) in
            let viewController = MediaTrailerListViewController()
            
            let viewModel = MediaTrailerListViewModel(with: mediaID, mediaType: mediaType, seasonNumber: seasonNumber, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            
            return (viewController: viewController, viewModel: viewModel, coordinator: coordinator)
        }
        
        container.register(Typealias.MediaTrailerListBundle.self)  { (r, coordinator: NavigationCoordinator, mediaID: String, mediaType: MediaType, seasonNumber: String, episodeNumber: String) in
            let viewController = MediaTrailerListViewController()
            
            let viewModel = MediaTrailerListViewModel(with: mediaID, mediaType: mediaType, seasonNumber: seasonNumber, episodeNumber: episodeNumber, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            
            return (viewController: viewController, viewModel: viewModel, coordinator: coordinator)
        }
        
        container.register(Typealias.CreditListBundle.self)  { (r, coordinator: NavigationCoordinator, mediaID: String, mediaType: MediaType, creditType: CreditType, seasonNumber: String?, episodeNumber: String?) in
            let viewController = CreditListViewController()
            
            let viewModel = CreditListViewModel(with: mediaID, mediaType: mediaType, creditType: creditType, seasonNumber: seasonNumber, episodeNumber: episodeNumber, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
            viewModel.coordinator = coordinator  as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            
            return (viewController: viewController, viewModel: viewModel, coordinator: coordinator)
        }
        
        container.register(Typealias.PeopleDetailBundle.self)  { (r, coordinator: PeopleFlowCoordinator, mediaID: String) in
            let viewController = PeopleDetailViewController()
            
            let viewModel = PeopleDetailViewModel(with: mediaID, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!, useCasePersistenceProvider: r.resolve(Domain.UseCasePersistenceProvider.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            
            return (viewController: viewController, viewModel: viewModel, coordinator: coordinator)
        }
        
        container.register(Typealias.SearchBundle.self)  { (r, coordinator: SearchFlowCoordinator) in
            let viewController = SearchViewController()
            
            let viewModel = SearchViewModel(useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            if (coordinator.navigationController.viewControllers.isEmpty) {
                coordinator.navigationController.pushViewController(viewController, animated: true)
            }
            
            return (viewController: viewController, viewModel: viewModel, coordinator: coordinator)
        }
        
        container.register(Typealias.FilterOptionListMediaBundle.self)  { (r, coordinator: SearchFlowCoordinator, searchCategory: SearchCategory) in
            let viewController = FilterOptionListMediaViewController()
            
            let viewModel = FilterOptionListMediaViewModel(searchCategory: searchCategory, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            
            return (viewController: viewController, viewModel: viewModel, coordinator: coordinator)
        }
        
        container.register(Typealias.MediaFilteredListBundle.self)  { (r, coordinator: SearchFlowCoordinator, mediaType: MediaType, mediaFilterType: MediaFilterType) in
            let viewController = MediaFilteredListViewController()
            
            let viewModel = MediaFilteredListViewModel(mediaType: mediaType, mediaFilterType: mediaFilterType, useCaseProvider: r.resolve(Domain.UseCaseProvider.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            coordinator.navigationController.pushViewController(viewController, animated: true)
            
            return (viewController: viewController, viewModel: viewModel, coordinator: coordinator)
        }
        
        
        container.register(Typealias.FavoriteBundle.self)  { (r, coordinator: FavoriteFlowCoordinator) in
            let viewController = FavoriteListViewController()
            
            let viewModel = FavoriteListViewModel(useCasePersistenceProvider: r.resolve(Domain.UseCasePersistenceProvider.self)!)
            viewModel.coordinator = coordinator as NavigationCoordinator
            viewController.bindViewModel(to: viewModel)
            if (coordinator.navigationController.viewControllers.isEmpty) {
                coordinator.navigationController.pushViewController(viewController, animated: true)
            }
            
            return (viewController: viewController, viewModel: viewModel, coordinator: coordinator)
        }
        
        
        
        
    }
        
}
