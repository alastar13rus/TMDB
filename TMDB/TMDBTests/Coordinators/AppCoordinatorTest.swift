//
//  AppCoordinatorTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 12.03.2021.
//

import XCTest
@testable import TMDB
@testable import Domain
@testable import NetworkPlatform

class AppCoordinatorTest: XCTestCase {
    
    func testCoordinator_store() {
        sut.store(spyTabBarCoordinator)
        
        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators[spyTabBarCoordinator.identifier] is SpyTabBarCoordinator)
        XCTAssertEqual(sut.childCoordinators[spyTabBarCoordinator.identifier] as! SpyTabBarCoordinator, spyTabBarCoordinator)
        
    }
    
    func testCoordinator_free() {
        sut.childCoordinators[spyTabBarCoordinator.identifier] = spyTabBarCoordinator
        sut.free(spyTabBarCoordinator)
        
        XCTAssertEqual(sut.childCoordinators.count, 0)
        XCTAssertFalse(sut.childCoordinators[spyTabBarCoordinator.identifier] is SpyTabBarCoordinator)
        
    }
    
    func testCoordinator_coordinate() {
        sut.coordinate(to: spyTabBarCoordinator)
        
        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators[spyTabBarCoordinator.identifier] is SpyTabBarCoordinator)
        XCTAssertEqual(sut.childCoordinators[spyTabBarCoordinator.identifier] as! SpyTabBarCoordinator, spyTabBarCoordinator)
        
    }
    
    
//    MARK : - Helpers
    
    let window = UIWindow()
    let tabBarController = UITabBarController()
    let container = AppDIContainer.shared
    lazy var sut = AppFlowCoordinator(window: window, tabBarController: tabBarController, container: container)
    lazy var spyTabBarCoordinator = SpyTabBarCoordinator(window: window, container: container)
    
    public class SpyTabBarCoordinator: TabBarCoordinator {}
    

}
