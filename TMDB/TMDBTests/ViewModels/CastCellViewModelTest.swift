//
//  CastCellViewModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 15.04.2021.
//

import XCTest
@testable import TMDB

class CastCellViewModelTest: XCTestCase {
    
    func test_initWithViewModel() {
        
        let castCellViewModel = CastCellViewModel(castModel)
        let castCellViewModel2 = CastCellViewModel(castCellViewModel)
        
        XCTAssertEqual(castCellViewModel2.identity, "ohfbksdbsf")
        XCTAssertEqual(castCellViewModel2.order, 99)

    }
    
    func test_identity() {
        
        let castCellViewModel = CastCellViewModel(castModel)
        
        XCTAssertEqual(castCellViewModel.identity, "ohfbksdbsf")
        
    }
    
    func test_profileImageData() {
        
        let castCellViewModel = CastCellViewModel(castModel)
        
        var imageData: Data?
        let expectation = self.expectation(description: #function)
        
        castCellViewModel.profileImageData { (data) in
            imageData = data
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNotNil(imageData)

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
