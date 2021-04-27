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

class MediaListViewModelTest: XCTestCase {
    
    func test_didChangeSelectedSegmentIndex_changedMovieEndpointAndResetedCurrentPage() {
        
        let sut = SpyMediaListViewModel(networkManager: NetworkManager())
        
        sut.currentPage = 3
        sut.input.selectedSegmentIndex.accept(0)
        sut.screen = .movie(MediaListTableViewDataSource.Screen.movieListInfo)

        XCTAssertEqual(sut.movieEndpoint, .topRated(page: 1))

        sut.currentPage = 5
        sut.input.selectedSegmentIndex.accept(1)

        XCTAssertEqual(sut.movieEndpoint, .popular(page: 1))
        
        
        sut.screen = .tv(MediaListTableViewDataSource.Screen.tvListInfo)

        sut.currentPage = 6
        sut.input.selectedSegmentIndex.accept(2)

        XCTAssertEqual(sut.movieEndpoint, .nowPlaying(page: 1))
        
        sut.currentPage = 7
        sut.input.selectedSegmentIndex.accept(3)
        
        XCTAssertEqual(sut.tvEndpoint, .airingToday(page: 1))
        

        let expectation = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
    }
    
    func test_subscribeSelectedSegmentIndex_defaultSetupSelectedSegmentIndex_noFetchingMedia() {
        
        let sut = SpyMediaListViewModel(networkManager: NetworkManager())
        
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
        
        let sut = SpyMediaListViewModel(networkManager: NetworkManager())
        
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
        
        let sut = SpyMediaListViewModel(networkManager: NetworkManager())
        
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
        
        let sut = SpyMediaListViewModel(networkManager: NetworkManager())
        
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
        
        let sut = SpyMediaListViewModel(networkManager: NetworkManager())
        
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
        
        let sut = SpyMediaListViewModel(networkManager: NetworkManager())
        
        sut.output.isFetching.accept(false)
        var movies = [MediaCellViewModel]()
        XCTAssertEqual(sut.output.media.value.count, 0)
        
        let expectation = self.expectation(description: #function)

        sut.testFetch { (fetchedMovies) in
            XCTAssertEqual(movies.count, 0)
            movies = fetchedMovies
            XCTAssertEqual(sut.output.isFetching.value, true)
            expectation.fulfill()
        }
        XCTAssertEqual(movies.count, 0)

        waitForExpectations(timeout: 10)

        XCTAssertEqual(sut.output.isFetching.value, false)
        XCTAssertEqual(movies.count, 20)
    }

    func test_fetchMedia_paramIsFetchingEqualTrue_noFetchingMedia() {
        
        let sut = SpyMediaListViewModel(networkManager: NetworkManager())

        sut.output.isFetching.accept(true)
        var media = [MediaCellViewModel]()
        XCTAssertEqual(sut.output.media.value.count, 0)

        let expectation = self.expectation(description: #function)

        sut.testFetch { (fetchedMedia) in
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
        
        let sut = SpyMediaListViewModel(networkManager: NetworkManager())
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

extension SpyMediaListViewModel {
    func testFetch(completion: @escaping ([MediaCellViewModel]) -> Void) {
        self.fetch() { (media) in
            completion(media)
        }
    }
}

let sut = SpyMediaListViewModel(networkManager: NetworkManager())

extension TmdbAPI.MovieEndpoint: Equatable {
    public static func ==(lhs: TmdbAPI.MovieEndpoint, rhs: TmdbAPI.MovieEndpoint) -> Bool {
            switch (lhs, rhs) {
            case (.credits(let lhsMediaID) , .credits(let rhsMediaID)):
                return lhsMediaID == rhsMediaID
            case (.details(let lhsMediaID) , .details(let rhsMediaID)):
                return lhsMediaID == rhsMediaID
            case (.nowPlaying(let lhsPage) , .nowPlaying(let rhsPage)):
                return lhsPage == rhsPage
            case (.popular(let lhsPage) , .popular(let rhsPage)):
                return lhsPage == rhsPage
            case (.recommendations(let lhsMediaID) , .recommendations(let rhsMediaID)):
                return lhsMediaID == rhsMediaID
            case (.topRated(let lhsPage) , .topRated(let rhsPage)):
                return lhsPage == rhsPage
            case (.upcoming(let lhsPage) , .upcoming(let rhsPage)):
                return lhsPage == rhsPage
            default:
                return false
            }
        }
}

extension TmdbAPI.TVEndpoint: Equatable {
    public static func ==(lhs: TmdbAPI.TVEndpoint, rhs: TmdbAPI.TVEndpoint) -> Bool {
            switch (lhs, rhs) {
            case (.credits(let lhsMediaID) , .credits(let rhsMediaID)):
                return lhsMediaID == rhsMediaID
            case (.details(let lhsMediaID) , .details(let rhsMediaID)):
                return lhsMediaID == rhsMediaID
            case (.airingToday(let lhsPage) , .airingToday(let rhsPage)):
                return lhsPage == rhsPage
            case (.popular(let lhsPage) , .popular(let rhsPage)):
                return lhsPage == rhsPage
            case (.recommendations(let lhsMediaID) , .recommendations(let rhsMediaID)):
                return lhsMediaID == rhsMediaID
            case (.topRated(let lhsPage) , .topRated(let rhsPage)):
                return lhsPage == rhsPage
            case (.onTheAir(let lhsPage) , .onTheAir(let rhsPage)):
                return lhsPage == rhsPage
            default:
                return false
            }
        }
}
