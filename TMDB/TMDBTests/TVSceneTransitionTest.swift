//
//  TVSceneTransitionTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import XCTest
@testable import TMDB
@testable import Domain
@testable import NetworkPlatform

class TVSceneTransitionTest: XCTestCase {
    
    func test_tvListTransitionToTVDetail_navigationControllerState() {
        
        let container = AppDIContainer.shared
        let coordinator = TVFlowCoordinator(navigationController: UINavigationController(), container: container)
        let (viewController, _, _) = container.resolve(Typealias.MediaListBundle.self, argument: coordinator as NavigationCoordinator)!
        
        let expectation = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
        
        viewController.mediaListTableView.delegate?.tableView?(viewController.mediaListTableView, didSelectRowAt: IndexPath(row: 2, section: 0))
        
        let expectation2 = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation2.fulfill()
        }
        waitForExpectations(timeout: 3)
        
        XCTAssertEqual(coordinator.navigationController.viewControllers.count, 2)

    }
    
    func test_tvListTransitionToTVDetail_mediaIDIsEqualToTVDetailID() {
        
        let container = AppDIContainer.shared
        let coordinator = TVFlowCoordinator(navigationController: UINavigationController(), container: container)
        let (viewController, _, _) = container.resolve(Typealias.MediaListBundle.self, argument: coordinator as NavigationCoordinator)!
        
        let expectation = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
        
        viewController.mediaListTableView.delegate?.tableView?(viewController.mediaListTableView, didSelectRowAt: IndexPath(row: 19, section: 0))
        
        let expectation2 = self.expectation(description: #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation2.fulfill()
        }
        waitForExpectations(timeout: 3)
        
        switch viewController.dataSource[0] {
        case .tvSection(_, let items):
            switch items[19] {
            case .tv(let vm):
                let detailID = (coordinator.navigationController.topViewController as! TVDetailViewController).viewModel.detailID
                XCTAssertEqual(detailID, vm.id)
            default: break
            }
        default: break
        }

    }
    
}
