//
//  TVDetailViewModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 15.04.2021.
//

import XCTest
@testable import TMDB

class TVDetailViewModelTest: XCTestCase {
    
    func test_init() {
        let (_, viewModel, _) = tvFlowCoordinator.factory(with: "1399", vmType: TVDetailViewModel.self, vcType: TVDetailViewController.self)
        
        XCTAssertEqual(viewModel.detailID, "1399")
        
        let expectation = self.expectation(description: #function)
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssert(viewModel.output.sectionedItems.value.count > 0)
    }
    
    func test_fetch() {
        let (_, viewModel, _) = tvFlowCoordinator.factory(with: "1399", vmType: TVDetailViewModel.self, vcType: TVDetailViewController.self)
        
        var tvDetail: TVDetailModel?
        let expectation = self.expectation(description: #function)
        viewModel.fetch { (fetchedTVDetail) in
            tvDetail = fetchedTVDetail
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNotNil(tvDetail)
    }
    
    

//    MARK: - Helpers
    var tvFlowCoordinator: TVFlowCoordinator {
        TVFlowCoordinator(navigationController: UINavigationController())
    }
    
    
    
}

