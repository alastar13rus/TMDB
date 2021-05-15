//
//  MediaFlowCoordinatorTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 17.03.2021.
//

import XCTest
@testable import TMDB

class MediaFlowCoordinatorTest: XCTestCase {
    
    func test_factory() {
        let (coordinator, viewModel, viewController) = sut.factory(vmType: MediaListViewModel.self, vcType: MediaListViewController.self)
        
        XCTAssertEqual(viewController.viewModel, viewModel)
        XCTAssertEqual(viewModel.coordinator as! MovieFlowCoordinator, coordinator)
    }
    
//    MARK: - Helpers
    let sut = MovieFlowCoordinator(navigationController: UINavigationController())
    
}

extension MediaListViewModel: Equatable {
    
    public static func == (lhs: MediaListViewModel, rhs: MediaListViewModel) -> Bool {
        return lhs === rhs
    }

}
