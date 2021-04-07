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
        XCTAssert(sut.childCoordinators.first?.value is MovieListCoordinator)
        
    }
    
    func testShowMovieTab() {
        sut.showMovieTab()
        
        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators.first?.value is MovieListCoordinator)
        
    }
    
    func testShowTVTab() {
        sut.showTVTab()
        
        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators.first?.value is TVListCoordinator)
        
    }
    
    func testSwitchTabs() {
        
        sut.showMovieTab()

        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators.first?.value is MovieListCoordinator)
        
        sut.free(sut.childCoordinators.first!.value)
        sut.showTVTab()
        
        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators.first?.value is TVListCoordinator)
        
        let removed = sut.childCoordinators.first { (key, value) -> Bool in
            return value is TVListCoordinator
        }
        
        sut.free(removed!.value)
        sut.showMovieTab()
        
        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators.first?.value is MovieListCoordinator)
        
        sut.showTVTab()
        
        XCTAssertEqual(sut.childCoordinators.count, 2)
        XCTAssert(sut.childCoordinators.contains(where: { (key, value) -> Bool in
            return value is MovieListCoordinator
        }))
        XCTAssert(sut.childCoordinators.contains(where: { (key, value) -> Bool in
            return value is TVListCoordinator
        }))
        
    }
    
    
    
    
//    MARK: - Helpers
    let sut: TabBarCoordinator = {
        let coordinator = TabBarCoordinator(window: UIWindow())
        return coordinator
    }()
    
    
}
