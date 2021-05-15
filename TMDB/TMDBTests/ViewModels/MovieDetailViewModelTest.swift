//
//  MovieDetailViewModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 14.04.2021.
//

import XCTest
@testable import TMDB

class MovieDetailViewModelTest: XCTestCase {
    
    func test_init() {
        let (_, viewModel, _) = movieFlowCoordinator.factory(with: "761053", vmType: MovieDetailViewModel.self, vcType: MovieDetailViewController.self)
        
        XCTAssertEqual(viewModel.detailID, "761053")
        
        let expectaition = self.expectation(description: #function)
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 5) {
            expectaition.fulfill()
        }
        
        waitForExpectations(timeout: 6, handler: nil)
        XCTAssert(viewModel.output.sectionedItems.value.count > 0)
    }
    
    func test_fetch() {
        let (_, viewModel, _) = movieFlowCoordinator.factory(with: "556574", vmType: MovieDetailViewModel.self, vcType: MovieDetailViewController.self)
        
        var movieDetail: MovieDetailModel?
        let expectation = self.expectation(description: #function)
        viewModel.fetch { (fetchedMovieDetail) in
            movieDetail = fetchedMovieDetail
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 6, handler: nil)
        XCTAssertNotNil(movieDetail)
    }
    
    

//    MARK: - Helpers
    var movieFlowCoordinator: MovieFlowCoordinator {
        MovieFlowCoordinator(navigationController: UINavigationController())
    }
    
    
    
}

