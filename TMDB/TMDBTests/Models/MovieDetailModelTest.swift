//
//  MovieDetailModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 14.04.2021.
//

import XCTest
@testable import TMDB
@testable import Domain

class MovieDetailModelTest: XCTestCase {
 
    func test_compare() {
        XCTAssertLessThan(movieDetail, movieDetail2)
    }
    
    func test_equal() {
        XCTAssertEqual(movieDetail, movieDetail3)

    }
    
//    MARK: - Helpers
    
    let movieDetail =
        MovieDetailModel(adult: false, backdropPath: nil, budget: 0, genres: [], homepage: "", id: 1, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: nil, productionCountries: [], productionCompanies: [], releaseDate: nil, revenue: 0, runtime: 60, spokenLanguages: [], status: "", tagline: "", title: "", voteAverage: 10, voteCount: 10, video: false, credits: nil, recommendations: nil, similar: nil, images: nil, videos: nil)
    
    let movieDetail2 =
        MovieDetailModel(adult: false, backdropPath: nil, budget: 0, genres: [], homepage: "", id: 2, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: nil, productionCountries: [], productionCompanies: [], releaseDate: nil, revenue: 0, runtime: 60, spokenLanguages: [], status: "", tagline: "", title: "", voteAverage: 10, voteCount: 10, video: false, credits: nil, recommendations: nil, similar: nil, images: nil, videos: nil)
    
    let movieDetail3 =
        MovieDetailModel(adult: false, backdropPath: nil, budget: 0, genres: [], homepage: "", id: 1, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: nil, productionCountries: [], productionCompanies: [], releaseDate: nil, revenue: 0, runtime: 60, spokenLanguages: [], status: "", tagline: "", title: "", voteAverage: 10, voteCount: 10, video: false, credits: nil, recommendations: nil, similar: nil, images: nil, videos: nil)
}
