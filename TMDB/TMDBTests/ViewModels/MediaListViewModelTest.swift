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
            let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: AppDIContainer.shared)
            let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider)
            viewModel.coordinator = coordinator
            return viewModel
        }()
        
        sut.currentPage = 3
        sut.input.selectedSegmentIndex.accept(0)
        sut.screen = .movie(MediaListTableViewDataSource.Screen.movieListInfo)

        XCTAssertNotNil(sut.movieMethod)

        sut.currentPage = 5
        sut.input.selectedSegmentIndex.accept(1)
        
        XCTAssertNotNil(sut.movieMethod)
        
        sut.screen = .tv(MediaListTableViewDataSource.Screen.tvListInfo)

        sut.currentPage = 6
        sut.input.selectedSegmentIndex.accept(2)
        
        XCTAssertNil(sut.movieMethod)
        XCTAssertNotNil(sut.tvMethod)
        
        sut.currentPage = 7
        sut.input.selectedSegmentIndex.accept(3)
        
        XCTAssertNil(sut.movieMethod)
        XCTAssertNotNil(sut.tvMethod)

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
            let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: AppDIContainer.shared)
            let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider)
            viewModel.coordinator = coordinator
            return viewModel
        }()
        
        sut.currentPage = 1
        
        let expectation = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3)
        XCTAssertEqual(sut.currentPage, 1)
        XCTAssertEqual(sut.numberOfMedia, 0)
        XCTAssertEqual(sut.output.media.value.count, 0)
        XCTAssertEqual(sut.currentPage, 1)


    }

    func test_subscribeSelectedSegmentIndex_didChangeSelectedSegmentIndex_mediaIsReplacedWithANextMedia() {
        
        let sut: SpyMediaListViewModel = {
            let network = NetworkAgent()
            let networkProvider = NetworkProvider(network: network)
            let appConfig = AppConfig()
            let config = (apiKey: appConfig.apiKey, apiBaseURL: appConfig.apiBaseURL)
            let apiFactory = APIFactory(config)
            let useCaseProvider = NetworkPlatform.UseCaseProvider(networkProvider: networkProvider, apiFactory: apiFactory)
            let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: AppDIContainer.shared)
            let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider)
            viewModel.coordinator = coordinator
            return viewModel
        }()
        
        sut.currentPage = 1
        sut.input.selectedSegmentIndex.accept(3)
        sut.input.selectedSegmentIndex.accept(2)
        sut.input.selectedSegmentIndex.accept(1)

        let expectation = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 6)
        XCTAssertEqual(sut.currentPage, 1)
        XCTAssertEqual(sut.numberOfMedia, 20)
        XCTAssertEqual(sut.output.media.value.count, 20)

    }

    func test_subscribeWillDisplayCellIndex_emptyCurrentMovies_noFetchingMedia() {
        
        let sut: SpyMediaListViewModel = {
            let network = NetworkAgent()
            let networkProvider = NetworkProvider(network: network)
            let appConfig = AppConfig()
            let config = (apiKey: appConfig.apiKey, apiBaseURL: appConfig.apiBaseURL)
            let apiFactory = APIFactory(config)
            let useCaseProvider = NetworkPlatform.UseCaseProvider(networkProvider: networkProvider, apiFactory: apiFactory)
            let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider)
            return viewModel
        }()
        
        let expectation = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3)
        XCTAssertEqual(sut.currentPage, 1)
        XCTAssertEqual(sut.numberOfMedia, 0)
        XCTAssertEqual(sut.output.media.value.count, 0)

    }

    func test_subscribeWillDisplayCellIndex_actualThresholdLessThanRequiredThreshold_startFetchingMedia() {
        
        let sut: SpyMediaListViewModel = {
            let network = NetworkAgent()
            let networkProvider = NetworkProvider(network: network)
            let appConfig = AppConfig()
            let config = (apiKey: appConfig.apiKey, apiBaseURL: appConfig.apiBaseURL)
            let apiFactory = APIFactory(config)
            let useCaseProvider = NetworkPlatform.UseCaseProvider(networkProvider: networkProvider, apiFactory: apiFactory)
            let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: AppDIContainer.shared)
            let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider)
            viewModel.coordinator = coordinator
            return viewModel
        }()
        
        sut.currentPage = 2
        sut.numberOfMedia = 40
        let fakeStartNumberOfMovies = sut.numberOfMedia
        sut.requiredThresholdNumberOfCells = 5
        sut.input.willDisplayCellIndex.accept(37)

        XCTAssertEqual(sut.actualThresholdNumberOfCells, sut.numberOfMedia - sut.input.willDisplayCellIndex.value)
        XCTAssertTrue(sut.isRequiredNextFetching)
            
        let expectation = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3)
        XCTAssertEqual(sut.currentPage, 3)

        XCTAssertEqual(sut.numberOfMedia + fakeStartNumberOfMovies, 60)
        XCTAssertEqual(sut.output.media.value.count + fakeStartNumberOfMovies, 60)
        XCTAssertEqual(sut.output.sectionedItems.value[0].items.count + fakeStartNumberOfMovies, 60)

    }

    func test_subscribeWillDisplayCellIndex_actualThresholdGreaterThanRequiredThreshold_noFetchingMedia() {
        
        let sut: SpyMediaListViewModel = {
            let network = NetworkAgent()
            let networkProvider = NetworkProvider(network: network)
            let appConfig = AppConfig()
            let config = (apiKey: appConfig.apiKey, apiBaseURL: appConfig.apiBaseURL)
            let apiFactory = APIFactory(config)
            let useCaseProvider = NetworkPlatform.UseCaseProvider(networkProvider: networkProvider, apiFactory: apiFactory)
            let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: AppDIContainer.shared)
            let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider)
            viewModel.coordinator = coordinator
            return viewModel
        }()
        
        sut.currentPage = 1
        sut.numberOfMedia = 35
        sut.requiredThresholdNumberOfCells = 5
        sut.input.willDisplayCellIndex.accept(28)
        
        XCTAssertEqual(sut.actualThresholdNumberOfCells, sut.numberOfMedia - sut.input.willDisplayCellIndex.value)
        XCTAssertFalse(sut.isRequiredNextFetching)
        
        let expectation = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3)
        XCTAssertEqual(sut.currentPage, 1)
        XCTAssertEqual(sut.numberOfMedia, 35)

    }

    func test_fetchMedia_paramIsFetchingEqualFalse_fetchingMedia() {
        
        let sut: SpyMediaListViewModel = {
            let network = NetworkAgent()
            let networkProvider = NetworkProvider(network: network)
            let appConfig = AppConfig()
            let config = (apiKey: appConfig.apiKey, apiBaseURL: appConfig.apiBaseURL)
            let apiFactory = APIFactory(config)
            let useCaseProvider = NetworkPlatform.UseCaseProvider(networkProvider: networkProvider, apiFactory: apiFactory)
            let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: AppDIContainer.shared)
            let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider)
            viewModel.coordinator = coordinator
            return viewModel
        }()
        
        sut.output.isFetching.accept(false)
        var movies = [MediaCellViewModel]()
        XCTAssertEqual(sut.output.media.value.count, 0)
        
        let expectation = self.expectation(description: #function)
        
        sut.fetch { (fetchedMovies) in
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
            let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: AppDIContainer.shared)
            let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider)
            viewModel.coordinator = coordinator
            return viewModel
        }()
        sut.output.isFetching.accept(true)
        var media = [MediaCellViewModel]()
        XCTAssertEqual(sut.output.media.value.count, 0)

        let expectation = self.expectation(description: #function)

        sut.fetch { (fetchedMedia) in
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
    
    func test_subscribeIsRefreshing_whenIsRefreshingEqualTrue_thenFetchingMoviesAndResetParams() {
        
        
        let sut: SpyMediaListViewModel = {
            let network = NetworkAgent()
            let networkProvider = NetworkProvider(network: network)
            let appConfig = AppConfig()
            let config = (apiKey: appConfig.apiKey, apiBaseURL: appConfig.apiBaseURL)
            let apiFactory = APIFactory(config)
            let useCaseProvider = NetworkPlatform.UseCaseProvider(networkProvider: networkProvider, apiFactory: apiFactory)
            let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: AppDIContainer.shared)
            let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider)
            viewModel.coordinator = coordinator
            return viewModel
        }()
        sut.input.isRefreshing.accept(true)
        
        let expectation = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        XCTAssertEqual(sut.output.media.value.count, 20)
        XCTAssertEqual(sut.currentPage, 1)
        XCTAssertEqual(sut.output.isRefreshing.value, false)
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
    let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: AppDIContainer.shared)
    let viewModel = SpyMediaListViewModel(useCaseProvider: useCaseProvider)
    viewModel.coordinator = coordinator
    return viewModel
}()
