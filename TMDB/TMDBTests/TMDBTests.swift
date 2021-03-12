//
//  TMDBTests.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 12.03.2021.
//

import XCTest
@testable import TMDB

class TMDBTests: XCTestCase {
    
    func testCoordinator_store() {
        sut.store(spyMovieCoordinator)
        
        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators[spyMovieCoordinator.identifier] is SpyMovieCoordinator)
        XCTAssertEqual(sut.childCoordinators[spyMovieCoordinator.identifier] as! SpyMovieCoordinator, spyMovieCoordinator)
        
    }
    
    func testCoordinator_free() {
        sut.childCoordinators[spyMovieCoordinator.identifier] = spyMovieCoordinator
        sut.free(spyMovieCoordinator)
        
        XCTAssertEqual(sut.childCoordinators.count, 0)
        XCTAssertFalse(sut.childCoordinators[spyMovieCoordinator.identifier] is SpyMovieCoordinator)
        
    }
    
    func testCoordinator_coordinate() {
        sut.coordinate(to: spyMovieCoordinator)
        
        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators[spyMovieCoordinator.identifier] is SpyMovieCoordinator)
        XCTAssertEqual(sut.childCoordinators[spyMovieCoordinator.identifier] as! SpyMovieCoordinator, spyMovieCoordinator)
        
    }
    
//    MARK : - Helpers
    let sut: AppCoordinator = {
        let window = UIWindow()
        let appCoordinator = AppCoordinator(window: window)
        return appCoordinator
    }()
    
    let spyMovieCoordinator = SpyMovieCoordinator()
    
    public class SpyMovieCoordinator: MovieCoordinator {
//        var identifier = UUID()
//        var childCoordinators = [UUID : Coordinator]()
//        var parentCoordinator: Coordinator?
        
        override func start() {
            
        }
    }
    

}
