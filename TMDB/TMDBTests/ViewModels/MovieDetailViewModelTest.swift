//
//  MovieDetailViewModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 14.04.2021.
//

import XCTest
import Swinject
@testable import TMDB
@testable import Domain

class MovieDetailViewModelTest: XCTestCase {
    
    func test_init() {
        let (_, viewModel, _) = container.resolve(Typealias.MovieDetailBundle.self, arguments: movieFlowCoordinator, "761053")!
        
        XCTAssertEqual(viewModel.detailID, "761053")
        
        let expectaition = self.expectation(description: #function)
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3) {
            expectaition.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(viewModel.output.sectionedItems.value.count > 0)
    }
    
    func test_fetch() {
        let (_, viewModel, _) = container.resolve(Typealias.MovieDetailBundle.self, arguments: movieFlowCoordinator, "556574")!
        
        var movieDetail: MovieDetailModel?
        let expectation = self.expectation(description: #function)
        viewModel.fetch { (fetchedMovieDetail) in
            movieDetail = fetchedMovieDetail
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(movieDetail)
    }
    
    

//    MARK: - Helpers
    var container: Container { AppDIContainer.shared }
    var movieFlowCoordinator: MovieFlowCoordinator {
        MovieFlowCoordinator(navigationController: UINavigationController(), container: container)
    }
    
}

