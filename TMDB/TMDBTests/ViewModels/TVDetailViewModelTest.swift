//
//  TVDetailViewModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 15.04.2021.
//

import XCTest
import Swinject
@testable import TMDB
@testable import Domain
@testable import NetworkPlatform
@testable import CoreDataPlatform

class TVDetailViewModelTest: XCTestCase {
    
    var useCaseProviderMock: UseCaseProviderMock!
    var useCasePersistenceProviderMock: UseCasePersistenceProviderMock!
    var networkMonitorMock: Domain.NetworkMonitor!

    override func setUp() {
        super.setUp()
        
        var container: Container { AppDIContainer.shared }
        useCaseProviderMock = UseCaseProviderMock(
            networkProvider: container.resolve(NetworkProvider.self)!,
            apiFactory: container.resolve(Domain.APIFactory.self)!)
        useCasePersistenceProviderMock = UseCasePersistenceProviderMock(dbProvider: container.resolve(CoreDataProvider.self)!)
        networkMonitorMock = NetworkMonitorMock.shared
    }
    
    override func tearDown() {
        super.tearDown()
        useCaseProviderMock = nil
        useCasePersistenceProviderMock = nil
        networkMonitorMock = nil
    }
    
    func test_init() {
        let viewModel = TVDetailViewModel(with: "71712",
                                          useCaseProvider: useCaseProviderMock,
                                          useCasePersistenceProvider: useCasePersistenceProviderMock, networkMonitor: networkMonitorMock)
        
        XCTAssertEqual(viewModel.detailID, "71712")
        
        let expectation = self.expectation(description: #function)
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 4) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(viewModel.output.sectionedItems.value.count > 0)
    }
    
    func test_fetch() {
        
        let viewModel = TVDetailViewModel(with: "71712",
                                          useCaseProvider: useCaseProviderMock,
                                          useCasePersistenceProvider: useCasePersistenceProviderMock, networkMonitor: networkMonitorMock)

        var tvDetail: TVDetailModel?
        let expectation = self.expectation(description: #function)
        viewModel.fetch { (fetchedTVDetail) in
            tvDetail = fetchedTVDetail
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(tvDetail)
    }
    
}

