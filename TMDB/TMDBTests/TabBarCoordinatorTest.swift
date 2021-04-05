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
    
    
    
    
//    MARK: - Helpers
    let sut: TabBarCoordinator = {

        let coordinator = TabBarCoordinator(window: UIWindow(), tabBarController: UITabBarController())
        
        
        return coordinator
    }()
    
    
}
