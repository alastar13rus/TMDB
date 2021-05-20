//
//  TabBarCoordinatorTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 05.04.2021.
//

import XCTest
@testable import TMDB

class TabBarCoordinatorTest: XCTestCase {
    
    func testChildCoordinators() {
        sut.start()
        
        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators.first?.value is MovieFlowCoordinator)
        
    }
    
    func testShowMovieTab() {
        sut.showMovieTab()
        
        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators.first?.value is MovieFlowCoordinator)
        
    }
    
    func testShowTVTab() {
        sut.showTVTab()
        
        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators.first?.value is TVFlowCoordinator)
        
    }
    
    func testSwitchTabs() {
        
        sut.showMovieTab()

        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators.first?.value is MovieFlowCoordinator)
        
        sut.free(sut.childCoordinators.first!.value)
        sut.showTVTab()
        
        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators.first?.value is TVFlowCoordinator)
        
        let removed = sut.childCoordinators.first { (key, value) -> Bool in
            return value is TVFlowCoordinator
        }
        
        sut.free(removed!.value)
        sut.showMovieTab()
        
        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators.first?.value is MovieFlowCoordinator)
        
        sut.showTVTab()
        
        XCTAssertEqual(sut.childCoordinators.count, 2)
        XCTAssert(sut.childCoordinators.contains(where: { (key, value) -> Bool in
            return value is MovieFlowCoordinator
        }))
        XCTAssert(sut.childCoordinators.contains(where: { (key, value) -> Bool in
            return value is TVFlowCoordinator
        }))
        
    }
    
    
    
    
//    MARK: - Helpers
    let sut: TabBarCoordinator = {
        let coordinator = TabBarCoordinator(window: UIWindow())
        return coordinator
    }()
    
    
}
