//
//  MediaFlowCoordinatorTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 17.03.2021.
//

import XCTest
import Swinject
@testable import TMDB
@testable import Domain

class MediaFlowCoordinatorTest: XCTestCase {
    
    func test_bundle() {
        let container = AppDIContainer.shared
        let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: container)
        let (viewController, viewModel, _) = container.resolve(Typealias.MediaListBundle.self, argument: coordinator as NavigationCoordinator)!
        
        XCTAssertEqual(viewController.viewModel, viewModel)
        XCTAssertEqual(viewModel.coordinator as! MovieFlowCoordinator, coordinator)
    }
}

//    MARK: - Helpers

extension MediaListViewModel: Equatable {
    
    public static func == (lhs: MediaListViewModel, rhs: MediaListViewModel) -> Bool {
        return lhs === rhs
    }

}
