//
//  TVRuntimeCellViewModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 13.04.2021.
//

import XCTest
@testable import TMDB

class TVRuntimeCellViewModelTest: XCTestCase {
    
    func test_initWithTVDetailModel_whenEpisodeRunTimeIs60Min_thenViewModelRuntimeTextContainsHoursCount() {
        let viewModel = TVRuntimeCellViewModel(model60)
        
        XCTAssertEqual(viewModel.id, "1")
        XCTAssertEqual(viewModel.episodeRunTime, 60)
        XCTAssertEqual(viewModel.runtimeText, "1 час")

    }
    
    func test_initWithTVDetailModel_whenEpisodeRunTimeLessThan60Min_thenViewModelRuntimeTextContainsMinutesCount() {
        let viewModel = TVRuntimeCellViewModel(model35)
        
        XCTAssertEqual(viewModel.id, "1")
        XCTAssertEqual(viewModel.episodeRunTime, 35)
        XCTAssertEqual(viewModel.runtimeText, "35 мин")

    }
    
    func test_initWithTVDetailModel_whenEpisodeRunTimeIsGreaterThen60Min_thenViewModelRuntimeTextContainsHoursAndMinutesCount() {
        let viewModel = TVRuntimeCellViewModel(model125)
        
        XCTAssertEqual(viewModel.id, "1")
        XCTAssertEqual(viewModel.episodeRunTime, 125)
        XCTAssertEqual(viewModel.runtimeText, "2 час 5 мин")

    }
    
    func test_initWithTVDetailModel_whenEpisodeRunTimeIsGreaterThen60MinAndIsMultiple60_thenViewModelRuntimeTextContainsHoursAndMinutesCount() {
        let viewModel = TVRuntimeCellViewModel(model180)
        
        XCTAssertEqual(viewModel.id, "1")
        XCTAssertEqual(viewModel.episodeRunTime, 180)
        XCTAssertEqual(viewModel.runtimeText, "3 час")

    }
    
    
//    MARK: - Helpers
    let model60 = TVDetailModel(
        backdropPath: nil,
        createdBy: [],
        episodeRunTime: [60],
        firstAirDate: "2021-01-01",
        genres: [],
        homepage: "",
        id: 1,
        inProduction: false,
        languages: [],
        lastAirDate: "2022-21-31",
        lastEpisodeToAir: TVEpisodeModel(),
        name: "Игра Престолов",
        networks: [],
        numberOfEpisodes: 73,
        numberOfSeasons: 8,
        originCountry: [],
        originalLanguage: "",
        originalName: "Game of Thrones",
        overview: "overview 1",
        popularity: 10,
        posterPath: nil,
        productionCompanies: [],
        seasons: [],
        status: "Released",
        tagline: "Winter is Coming",
        type: "",
        voteAverage: 10,
        voteCount: 100,
        credits: nil)
    
    let model35 = TVDetailModel(
        backdropPath: nil,
        createdBy: [],
        episodeRunTime: [35],
        firstAirDate: "2021-01-01",
        genres: [],
        homepage: "",
        id: 1,
        inProduction: false,
        languages: [],
        lastAirDate: "2022-21-31",
        lastEpisodeToAir: TVEpisodeModel(),
        name: "Игра Престолов",
        networks: [],
        numberOfEpisodes: 73,
        numberOfSeasons: 8,
        originCountry: [],
        originalLanguage: "",
        originalName: "Game of Thrones",
        overview: "overview 1",
        popularity: 10,
        posterPath: nil,
        productionCompanies: [],
        seasons: [],
        status: "Released",
        tagline: "Winter is Coming",
        type: "",
        voteAverage: 10,
        voteCount: 100,
        credits: nil)
    
    let model180 = TVDetailModel(
        backdropPath: nil,
        createdBy: [],
        episodeRunTime: [180],
        firstAirDate: "2021-01-01",
        genres: [],
        homepage: "",
        id: 1,
        inProduction: false,
        languages: [],
        lastAirDate: "2022-21-31",
        lastEpisodeToAir: TVEpisodeModel(),
        name: "Игра Престолов",
        networks: [],
        numberOfEpisodes: 73,
        numberOfSeasons: 8,
        originCountry: [],
        originalLanguage: "",
        originalName: "Game of Thrones",
        overview: "overview 1",
        popularity: 10,
        posterPath: nil,
        productionCompanies: [],
        seasons: [],
        status: "Released",
        tagline: "Winter is Coming",
        type: "",
        voteAverage: 10,
        voteCount: 100,
        credits: nil)
    
    let model125 = TVDetailModel(
        backdropPath: nil,
        createdBy: [],
        episodeRunTime: [125],
        firstAirDate: "2021-01-01",
        genres: [],
        homepage: "",
        id: 1,
        inProduction: false,
        languages: [],
        lastAirDate: "2022-21-31",
        lastEpisodeToAir: TVEpisodeModel(),
        name: "Игра Престолов",
        networks: [],
        numberOfEpisodes: 73,
        numberOfSeasons: 8,
        originCountry: [],
        originalLanguage: "",
        originalName: "Game of Thrones",
        overview: "overview 1",
        popularity: 10,
        posterPath: nil,
        productionCompanies: [],
        seasons: [],
        status: "Released",
        tagline: "Winter is Coming",
        type: "",
        voteAverage: 10,
        voteCount: 100,
        credits: nil)
    
}
