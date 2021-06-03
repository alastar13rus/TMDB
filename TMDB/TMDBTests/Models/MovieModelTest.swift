//
//  MovieModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 15.04.2021.
//

import XCTest
@testable import TMDB
@testable import Domain
@testable import NetworkPlatform

class MovieModelTest: XCTestCase {
 
    func test_compare() {
        XCTAssertLessThan(movieModel, movieModel2)
    }
    
    func test_equal() {
        XCTAssertEqual(movieModel, movieModel3)

    }
    
//    MARK: - Helpers
    
    let movieModel = MovieModel(posterPath: nil, adult: false, overview: "", releaseDate: "2021-01-01", genreIds: [], id: 0, originalTitle: "", originalLanguage: "", title: "Title 1", backdropPath: nil, popularity: 0, voteCount: 0, video: false, voteAverage: 0)
    
    let movieModel2 = MovieModel(posterPath: nil, adult: false, overview: "", releaseDate: "2021-01-01", genreIds: [], id: 0, originalTitle: "", originalLanguage: "", title: "Title 2", backdropPath: nil, popularity: 0, voteCount: 0, video: false, voteAverage: 0)
    
    let movieModel3 = MovieModel(posterPath: nil, adult: false, overview: "", releaseDate: "2021-01-01", genreIds: [], id: 0, originalTitle: "", originalLanguage: "", title: "Title 1", backdropPath: nil, popularity: 0, voteCount: 0, video: false, voteAverage: 0)
    
}
