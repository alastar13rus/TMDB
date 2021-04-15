//
//  MediaListCoordinatorTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 17.03.2021.
//

import XCTest
@testable import TMDB

class MediaListCoordinatorTest: XCTestCase {
    
    func test_factory() {
        let (coordinator, viewModel, viewController) = sut.factory(vmType: MediaListViewModel.self, vcType: MediaListViewController.self)
        
        XCTAssertEqual(viewController.viewModel, viewModel)
        XCTAssertEqual(viewModel.coordinator as! MovieListCoordinator, coordinator)
    }
    
//    MARK: - Helpers
    let sut = MovieListCoordinator(navigationController: UINavigationController())
    
}

extension MediaListViewModel: Equatable {
    
    public static func == (lhs: MediaListViewModel, rhs: MediaListViewModel) -> Bool {
        return lhs === rhs
    }

}
