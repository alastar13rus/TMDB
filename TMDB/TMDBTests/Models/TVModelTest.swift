//
//  TVModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 15.04.2021.
//

import XCTest
@testable import TMDB
@testable import Domain

class TVModelTest: XCTestCase {
 
    func test_compare() {
        XCTAssertLessThan(tvModel, tvModel2)
    }
    
    func test_equal() {
        XCTAssertEqual(tvModel, tvModel3)

    }
    
//    MARK: - Helpers
    
    let tvModel = TVModel(firstAirDate: nil, originCountry: [], name: "Title 1", originalName: "", id: 1, popularity: 0, voteCount: 0, posterPath: nil, backdropPath: nil, originalLanguage: "", genreIds: [], voteAverage: 0, overview: "")
    
    let tvModel2 = TVModel(firstAirDate: nil, originCountry: [], name: "Title 2", originalName: "", id: 1, popularity: 0, voteCount: 0, posterPath: nil, backdropPath: nil, originalLanguage: "", genreIds: [], voteAverage: 0, overview: "")
    
    let tvModel3 = TVModel(firstAirDate: nil, originCountry: [], name: "Title 1", originalName: "", id: 1, popularity: 0, voteCount: 0, posterPath: nil, backdropPath: nil, originalLanguage: "", genreIds: [], voteAverage: 0, overview: "")
    
}
