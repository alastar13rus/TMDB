//
//  TVDetailViewModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 15.04.2021.
//

import XCTest
@testable import Swinject
@testable import TMDB
@testable import Domain

class TVDetailViewModelTest: XCTestCase {
    
    func test_init() {
        
        let (_, viewModel, _) = container.resolve(Typealias.TVDetailBundle.self, arguments: tvFlowCoordinator, "1399")!
        
        XCTAssertEqual(viewModel.detailID, "1399")
        
        let expectation = self.expectation(description: #function)
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 10) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 11, handler: nil)
        XCTAssertTrue(viewModel.output.sectionedItems.value.count > 0)
    }
    
    func test_fetch() {
        
        let (_, viewModel, _) = container.resolve(Typealias.TVDetailBundle.self, arguments: tvFlowCoordinator, "1399")!
        
        var tvDetail: TVDetailModel?
        let expectation = self.expectation(description: #function)
        viewModel.fetch { (fetchedTVDetail) in
            tvDetail = fetchedTVDetail
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 11, handler: nil)
        XCTAssertNotNil(tvDetail)
    }
    
//    MARK: - Helpers
    
    var container: Container { AppDIContainer.shared }
    var tvFlowCoordinator: TVFlowCoordinator {
        TVFlowCoordinator(navigationController: UINavigationController(), container: container)
    }
    
}

