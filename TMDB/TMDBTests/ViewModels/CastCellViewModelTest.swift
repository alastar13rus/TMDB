//
//  CastCellViewModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 15.04.2021.
//

import XCTest
@testable import TMDB
@testable import Domain
@testable import NetworkPlatform

class CastCellViewModelTest: XCTestCase {
    
    func test_init() {
        
        let castCellViewModel = CastCellViewModel(castModel)
        
        XCTAssertEqual(castCellViewModel.identity, "ohfbksdbsf")
        XCTAssertEqual(castCellViewModel.order, 1)

    }
    
    func test_identity() {
        
        let castCellViewModel = CastCellViewModel(castModel)
        
        XCTAssertEqual(castCellViewModel.identity, "ohfbksdbsf")
        
    }
    
    func test_equal() {
        let castCellViewModel = CastCellViewModel(castModel)
        let castCellViewModel3 = CastCellViewModel(castModel)

        XCTAssertEqual(castCellViewModel, castCellViewModel3)

    }
    
    func test_compare() {
        let castCellViewModel = CastCellViewModel(castModel)
        let castCellViewModel2 = CastCellViewModel(castModel2)

        XCTAssertLessThan(castCellViewModel, castCellViewModel2)

    }
    
//    MARK: - Helpers
    let castModel = CastModel(adult: false, gender: 1, id: 192, knownForDepartment: "", name: "Name 1", originalName: "", popularity: 0, profilePath: "/yvmKPlTIi0xdcFQIFcQKQJcI63W.jpg", character: "", creditID: "ohfbksdbsf", order: 1)
    
    let castModel2 = CastModel(adult: false, gender: 1, id: 1312450, knownForDepartment: "", name: "Name 2", originalName: "", popularity: 0, profilePath: "/lbUQ7ilvBtWMU23reKsHg3jRmsf.jpg", character: "", creditID: "5f25dbe72d8ef30035d4c8d8", order: 2)
}
