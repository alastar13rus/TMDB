//
//  TVSceneTransitionTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import XCTest
@testable import TMDB

class TVSceneTransitionTest: XCTestCase {
    
    func test_tvListTransitionToTVDetail_navigationControllerState() {
        
        let sut = spyTVListCoordinator.factory(vmType: SpyTVListViewModel.self, vcType: SpyTVListViewController.self)
        
        
        let expectation = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
        
        sut.viewController.mediaListTableView.delegate?.tableView?(sut.viewController.mediaListTableView, didSelectRowAt: IndexPath(row: 2, section: 0))
        
        let expectation2 = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation2.fulfill()
        }
        waitForExpectations(timeout: 3)
        
        XCTAssertEqual(sut.coordinator.navigationController.viewControllers.count, 2)

    }
    
    func test_tvListTransitionToTVDetail_mediaIDIsEqualToTVDetailID() {
        
        let sut = spyTVListCoordinator.factory(vmType: SpyTVListViewModel.self, vcType: SpyTVListViewController.self)
        
        
        let expectation = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
        
        sut.viewController.mediaListTableView.delegate?.tableView?(sut.viewController.mediaListTableView, didSelectRowAt: IndexPath(row: 19, section: 0))
        
        let expectation2 = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation2.fulfill()
        }
        waitForExpectations(timeout: 3)
        
        switch sut.viewController.mediaListDataSource[0] {
        case .tvSection(_, let items):
            switch items[19] {
            case .tv(let vm):
                let detailID = (sut.coordinator.navigationController.topViewController as! TVDetailViewController).viewModel.detailID
                XCTAssertEqual(detailID, vm.id)
            default: break
            }
        default: break
        }

    }
    
    
    
//    MARK: - Helpers
    var spyTVListCoordinator = SpyTVListCoordinator(navigationController: UINavigationController())
    class SpyTVListCoordinator: TVListCoordinator { }
    class SpyTVListViewModel: MediaListViewModel { }
    class SpyTVListViewController: MediaListViewController { }

}
