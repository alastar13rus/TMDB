//
//  MovieRuntimeCellViewModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 13.04.2021.
//

import XCTest
@testable import TMDB
@testable import Domain

class MovieRuntimeCellViewModelTest: XCTestCase {
    
    func test_initWithMovieDetailModel_whenRuntimeIs60Min_thenViewModelRuntimeTextContainsHoursCount() {
        let viewModel = MovieRuntimeCellViewModel(model60)
        
        XCTAssertEqual(viewModel.id, "1")
        XCTAssertEqual(viewModel.runtime, 60)
        XCTAssertEqual(viewModel.runtimeText, "1 час")

    }
    
    func test_initWithMovieDetailModel_whenRuntimeLessThan60Min_thenViewModelRuntimeTextContainsMinutesCount() {
        let viewModel = MovieRuntimeCellViewModel(model35)

        XCTAssertEqual(viewModel.id, "1")
        XCTAssertEqual(viewModel.runtime, 35)
        XCTAssertEqual(viewModel.runtimeText, "35 мин")

    }

    func test_initWithMovieDetailModel_whenRuntimeIsGreaterThen60Min_thenViewModelRuntimeTextContainsHoursAndMinutesCount() {
        let viewModel = MovieRuntimeCellViewModel(model125)

        XCTAssertEqual(viewModel.id, "1")
        XCTAssertEqual(viewModel.runtime, 125)
        XCTAssertEqual(viewModel.runtimeText, "2 час 5 мин")

    }

    func test_initWithMovieDetailModel_whenRuntimeIsGreaterThen60MinAndIsMultiple60_thenViewModelRuntimeTextContainsHoursAndMinutesCount() {
        let viewModel = MovieRuntimeCellViewModel(model180)

        XCTAssertEqual(viewModel.id, "1")
        XCTAssertEqual(viewModel.runtime, 180)
        XCTAssertEqual(viewModel.runtimeText, "3 час")

    }
    
    
//    MARK: - Helpers
    
    let model60 = MovieDetailModel(adult: false, backdropPath: nil, budget: 0, genres: [], homepage: "", id: 1, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: nil, productionCountries: [], productionCompanies: [], releaseDate: nil, revenue: 0, runtime: 60, spokenLanguages: [], status: "", tagline: "", title: "", voteAverage: 10, voteCount: 10, video: false, credits: nil, recommendations: nil, similar: nil, images: nil, videos: nil)
    
    let model35 = MovieDetailModel(adult: false, backdropPath: nil, budget: 0, genres: [], homepage: "", id: 1, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: nil, productionCountries: [], productionCompanies: [], releaseDate: nil, revenue: 0, runtime: 35, spokenLanguages: [], status: "", tagline: "", title: "", voteAverage: 10, voteCount: 10, video: false, credits: nil, recommendations: nil, similar: nil, images: nil, videos: nil)
    
    let model125 = MovieDetailModel(adult: false, backdropPath: nil, budget: 0, genres: [], homepage: "", id: 1, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: nil, productionCountries: [], productionCompanies: [], releaseDate: nil, revenue: 0, runtime: 125, spokenLanguages: [], status: "", tagline: "", title: "", voteAverage: 10, voteCount: 10, video: false, credits: nil, recommendations: nil, similar: nil, images: nil, videos: nil)
    
    let model180 = MovieDetailModel(adult: false, backdropPath: nil, budget: 0, genres: [], homepage: "", id: 1, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: nil, productionCountries: [], productionCompanies: [], releaseDate: nil, revenue: 0, runtime: 180, spokenLanguages: [], status: "", tagline: "", title: "", voteAverage: 10, voteCount: 10, video: false, credits: nil, recommendations: nil, similar: nil, images: nil, videos: nil)
}
