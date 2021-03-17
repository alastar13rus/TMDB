//
//  AppCoordinatorTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 12.03.2021.
//

import XCTest
@testable import TMDB

class AppCoordinatorTest: XCTestCase {
    
    func testCoordinator_store() {
        sut.store(spyMovieListCoordinator)
        
        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators[spyMovieListCoordinator.identifier] is SpyMovieListCoordinator)
        XCTAssertEqual(sut.childCoordinators[spyMovieListCoordinator.identifier] as! SpyMovieListCoordinator, spyMovieListCoordinator)
        
    }
    
    func testCoordinator_free() {
        sut.childCoordinators[spyMovieListCoordinator.identifier] = spyMovieListCoordinator
        sut.free(spyMovieListCoordinator)
        
        XCTAssertEqual(sut.childCoordinators.count, 0)
        XCTAssertFalse(sut.childCoordinators[spyMovieListCoordinator.identifier] is SpyMovieListCoordinator)
        
    }
    
    func testCoordinator_coordinate() {
        sut.coordinate(to: spyMovieListCoordinator)
        
        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators[spyMovieListCoordinator.identifier] is SpyMovieListCoordinator)
        XCTAssertEqual(sut.childCoordinators[spyMovieListCoordinator.identifier] as! SpyMovieListCoordinator, spyMovieListCoordinator)
        
    }
    
//    MARK : - Helpers
    
    let window = UIWindow()
    lazy var sut = AppCoordinator(window: window)
    lazy var spyMovieListCoordinator = SpyMovieListCoordinator(window: window)
    
    public class SpyMovieListCoordinator: MovieListCoordinator {}
    

}
