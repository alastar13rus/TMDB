//
//  MovieListCoordinatorTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 17.03.2021.
//

import XCTest
@testable import TMDB

class MovieListCoordinatorTest: XCTestCase {
    
    func test_factory() {
        let (coordinator, viewModel, viewController) = sut.factory()
        
        XCTAssertEqual(viewController.viewModel, viewModel)
        XCTAssertEqual(viewModel.coordinator, coordinator)
    }
    
//    MARK: - Helpers
    let sut = MovieListCoordinator(window: UIWindow(), navigationController: UINavigationController())
    
}

extension MovieListViewModel: Equatable {
    
    public static func == (lhs: MovieListViewModel, rhs: MovieListViewModel) -> Bool {
        return lhs === rhs
    }

}
