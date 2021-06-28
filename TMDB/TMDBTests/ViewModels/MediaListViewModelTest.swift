//
//  MediaListViewModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 21.03.2021.
//

import XCTest
import RxSwift
import RxCocoa
@testable import TMDB
@testable import Domain
@testable import NetworkPlatform

class MediaListViewModelTest: XCTestCase {
    
    func test_didChangeSelectedSegmentIndex_changedMovieMethodAndResetedCurrentPage() {
        
        let sut: SpyMediaListViewModel = {
            let network = NetworkAgent()
            let networkProvider = NetworkProvider(network: network)
            let appConfig = AppConfig()
            let config = (apiKey: appConfig.apiKey, apiBaseURL: appConfig.apiBaseURL)
            let apiFactory = APIFactory(config)
            let useCaseProvider = NetworkPlatform.UseCaseProvider(networkProvider: networkProvider, apiFactory: apiFactory)
            let networkMonitor = NetworkMonitorMock.shared
            let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: AppDIContainer.shared)
            let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider, networkMonitor: networkMonitor)
            viewModel.coordinator = coordinator
            return viewModel
        }()
        
        sut.state.currentPage = 3
        sut.input.selectedSegmentIndex.accept(0)
        sut.screen = .movie(MediaListTableViewDataSource.Screen.movieListInfo)

        XCTAssertNotNil(sut.movieMethod)
        XCTAssertEqual(sut.state.currentPage, 1)

        sut.state.currentPage = 5
        sut.input.selectedSegmentIndex.accept(1)
        
        XCTAssertNotNil(sut.movieMethod)
        XCTAssertEqual(sut.state.currentPage, 1)
        
        sut.screen = .tv(MediaListTableViewDataSource.Screen.tvListInfo)

        sut.state.currentPage = 6
        sut.input.selectedSegmentIndex.accept(2)
        
        XCTAssertNil(sut.movieMethod)
        XCTAssertNotNil(sut.tvMethod)
        XCTAssertEqual(sut.state.currentPage, 1)
        
        sut.state.currentPage = 7
        sut.input.selectedSegmentIndex.accept(3)
        
        XCTAssertNil(sut.movieMethod)
        XCTAssertNotNil(sut.tvMethod)
        XCTAssertEqual(sut.state.currentPage, 1)

        let expectation = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
    }
    
    func test_subscribeSelectedSegmentIndex_defaultSetupSelectedSegmentIndex_noFetchingMedia() {
        
        let sut: SpyMediaListViewModel = {
            let network = NetworkAgent()
            let networkProvider = NetworkProvider(network: network)
            let appConfig = AppConfig()
            let config = (apiKey: appConfig.apiKey, apiBaseURL: appConfig.apiBaseURL)
            let apiFactory = APIFactory(config)
            let useCaseProvider = NetworkPlatform.UseCaseProvider(networkProvider: networkProvider, apiFactory: apiFactory)
            let networkMonitor = NetworkMonitorMock.shared
            let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: AppDIContainer.shared)
            let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider, networkMonitor: networkMonitor)
            viewModel.coordinator = coordinator
            return viewModel
        }()
        
        sut.state.currentPage = 1
        
        let expectation = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3)
        XCTAssertEqual(sut.state.currentPage, 1)
        XCTAssertEqual(sut.state.numberOfMedia, 0)
        XCTAssertEqual(sut.state.currentPage, 1)


    }

    func test_subscribeSelectedSegmentIndex_didChangeSelectedSegmentIndex_mediaIsReplacedWithANextMedia() {
        
        let sut: SpyMediaListViewModel = {
            let network = NetworkAgent()
            let networkProvider = NetworkProvider(network: network)
            let appConfig = AppConfig()
            let config = (apiKey: appConfig.apiKey, apiBaseURL: appConfig.apiBaseURL)
            let apiFactory = APIFactory(config)
            let useCaseProvider = NetworkPlatform.UseCaseProvider(networkProvider: networkProvider, apiFactory: apiFactory)
            let networkMonitor = NetworkMonitorMock.shared
            let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: AppDIContainer.shared)
            let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider, networkMonitor: networkMonitor)
            viewModel.coordinator = coordinator
            return viewModel
        }()
        
        sut.state.currentPage = 1
        sut.input.selectedSegmentIndex.accept(3)
        sut.input.selectedSegmentIndex.accept(2)
        sut.input.selectedSegmentIndex.accept(1)

        let expectation = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 6)
        XCTAssertEqual(sut.state.currentPage, 1)
        XCTAssertEqual(sut.state.numberOfMedia, 20)

    }

    func test_subscribeLoadNextPageTrigger_emptyCurrentMovies_noFetchingMedia() {
        
        let sut: SpyMediaListViewModel = {
            let network = NetworkAgent()
            let networkProvider = NetworkProvider(network: network)
            let appConfig = AppConfig()
            let config = (apiKey: appConfig.apiKey, apiBaseURL: appConfig.apiBaseURL)
            let apiFactory = APIFactory(config)
            let useCaseProvider = NetworkPlatform.UseCaseProvider(networkProvider: networkProvider, apiFactory: apiFactory)
            let networkMonitor = NetworkMonitorMock.shared
            let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider, networkMonitor: networkMonitor)
            return viewModel
        }()
        
        let expectation = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3)
        XCTAssertEqual(sut.state.currentPage, 0)
        XCTAssertEqual(sut.state.numberOfMedia, 0)

    }

    func test_subscribeLoadNextPageTrigger_startFetchingMedia() {
        
        let sut: SpyMediaListViewModel = {
            let network = NetworkAgent()
            let networkProvider = NetworkProvider(network: network)
            let appConfig = AppConfig()
            let config = (apiKey: appConfig.apiKey, apiBaseURL: appConfig.apiBaseURL)
            let apiFactory = APIFactory(config)
            let useCaseProvider = NetworkPlatform.UseCaseProvider(networkProvider: networkProvider, apiFactory: apiFactory)
            let networkMonitor = NetworkMonitorMock.shared
            let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: AppDIContainer.shared)
            let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider, networkMonitor: networkMonitor)
            viewModel.coordinator = coordinator
            return viewModel
        }()
        
        sut.state.currentPage = 2
        sut.state.numberOfMedia = 40
        sut.input.loadNextPageTrigger.accept(Void())

        let expectation = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3)
        XCTAssertEqual(sut.state.currentPage, 3)

        XCTAssertEqual(sut.state.numberOfMedia, sut.output.sectionedItems.value[0].items.count)

    }

    func test_fetchMedia_paramIsFetchingEqualFalse_fetchingMedia() {
        
        let sut: SpyMediaListViewModel = {
            let network = NetworkAgent()
            let networkProvider = NetworkProvider(network: network)
            let appConfig = AppConfig()
            let config = (apiKey: appConfig.apiKey, apiBaseURL: appConfig.apiBaseURL)
            let apiFactory = APIFactory(config)
            let useCaseProvider = NetworkPlatform.UseCaseProvider(networkProvider: networkProvider, apiFactory: apiFactory)
            let networkMonitor = NetworkMonitorMock.shared
            let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: AppDIContainer.shared)
            let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider, networkMonitor: networkMonitor)
            viewModel.coordinator = coordinator
            return viewModel
        }()
        
        sut.output.isFetching.accept(false)
        var movies = [MediaCellViewModel]()
        XCTAssertEqual(sut.state.numberOfMedia, 0)
        
        let expectation = self.expectation(description: #function)
        
        sut.fetch(1) { (fetchedMovies) in
            XCTAssertEqual(movies.count, 0)
            XCTAssertEqual(sut.output.isFetching.value, false)
            movies = fetchedMovies
            expectation.fulfill()
        }
        XCTAssertEqual(movies.count, 0)
        XCTAssertEqual(sut.output.isFetching.value, true)

        waitForExpectations(timeout: 10)

        XCTAssertEqual(sut.output.isFetching.value, false)
        XCTAssertEqual(movies.count, 20)
    }

    func test_fetchMedia_paramIsFetchingEqualTrue_noFetchingMedia() {
        
        let sut: SpyMediaListViewModel = {
            let network = NetworkAgent()
            let networkProvider = NetworkProvider(network: network)
            let appConfig = AppConfig()
            let config = (apiKey: appConfig.apiKey, apiBaseURL: appConfig.apiBaseURL)
            let apiFactory = APIFactory(config)
            let useCaseProvider = NetworkPlatform.UseCaseProvider(networkProvider: networkProvider, apiFactory: apiFactory)
            let networkMonitor = NetworkMonitorMock.shared
            let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: AppDIContainer.shared)
            let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider, networkMonitor: networkMonitor)
            viewModel.coordinator = coordinator
            return viewModel
        }()
        sut.output.isFetching.accept(true)
        var media = [MediaCellViewModel]()
        XCTAssertEqual(sut.state.numberOfMedia, 0)

        let expectation = self.expectation(description: #function)

        sut.fetch(1) { (fetchedMedia) in
            XCTAssertEqual(media.count, 0)
            media = fetchedMedia
            XCTAssertEqual(sut.output.isFetching.value, true)
            expectation.fulfill()
        }
        XCTAssertEqual(media.count, 0)

        waitForExpectations(timeout: 3)

        XCTAssertEqual(sut.output.isFetching.value, true)
        XCTAssertEqual(media.count, 0)
    }
    
    func test_subscribeRefreshItemsTrigger_fetchingMoviesAndResetParams() {
        
        
        let sut: SpyMediaListViewModel = {
            let network = NetworkAgent()
            let networkProvider = NetworkProvider(network: network)
            let appConfig = AppConfig()
            let config = (apiKey: appConfig.apiKey, apiBaseURL: appConfig.apiBaseURL)
            let apiFactory = APIFactory(config)
            let useCaseProvider = NetworkPlatform.UseCaseProvider(networkProvider: networkProvider, apiFactory: apiFactory)
            let networkMonitor = NetworkMonitorMock.shared
            let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: AppDIContainer.shared)
            let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider, networkMonitor: networkMonitor)
            viewModel.coordinator = coordinator
            return viewModel
        }()
        sut.input.refreshItemsTrigger.accept(Void())
        
        let expectation = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        XCTAssertEqual(sut.state.numberOfMedia, 20)
        XCTAssertEqual(sut.state.currentPage, 1)
        XCTAssertEqual(sut.output.isFetching.value, false)
    }
    
}


//  MARK: - Heplers

class SpyMediaListViewModel: MediaListViewModel { }

let sut: SpyMediaListViewModel = {
    let network = NetworkAgent()
    let networkProvider = NetworkProvider(network: network)
    let appConfig = AppConfig()
    let config = (apiKey: appConfig.apiKey, apiBaseURL: appConfig.apiBaseURL)
    let apiFactory = APIFactory(config)
    let useCaseProvider = NetworkPlatform.UseCaseProvider(networkProvider: networkProvider, apiFactory: apiFactory)
    let networkMonitor: Domain.NetworkMonitor = NetworkMonitorMock.shared
    let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: AppDIContainer.shared)
    let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider, networkMonitor: networkMonitor)
    viewModel.coordinator = coordinator
    return viewModel
}()
