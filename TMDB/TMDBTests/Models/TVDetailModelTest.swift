//
//  TVDetailModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 14.04.2021.
//

import XCTest
@testable import TMDB

class TVDetailModelTest: XCTestCase {
 
    func test_compare() {
        XCTAssertLessThan(tvDetail, tvDetail2)
    }
    
    func test_equal() {
        XCTAssertEqual(tvDetail, tvDetail3)

    }
    
//    MARK: - Helpers
    
    let tvDetail = TVDetailModel(backdropPath: nil, createdBy: [], episodeRunTime: [60], firstAirDate: "", genres: [], homepage: "", id: 1, inProduction: false, languages: [], lastAirDate: "", lastEpisodeToAir: TVEpisodeModel(), name: "serial 1", networks: [], numberOfEpisodes: 9, numberOfSeasons: 3, originCountry: [], originalLanguage: "", originalName: "", overview: "", popularity: 0, posterPath: nil, productionCompanies: [], seasons: [], status: "", tagline: "", type: "", voteAverage: 0, voteCount: 0, credits: nil)
    
    let tvDetail2 = TVDetailModel(backdropPath: nil, createdBy: [], episodeRunTime: [60], firstAirDate: "", genres: [], homepage: "", id: 2, inProduction: false, languages: [], lastAirDate: "", lastEpisodeToAir: TVEpisodeModel(), name: "serial 2", networks: [], numberOfEpisodes: 9, numberOfSeasons: 3, originCountry: [], originalLanguage: "", originalName: "", overview: "", popularity: 0, posterPath: nil, productionCompanies: [], seasons: [], status: "", tagline: "", type: "", voteAverage: 0, voteCount: 0, credits: nil)
    
    let tvDetail3 = TVDetailModel(backdropPath: nil, createdBy: [], episodeRunTime: [60], firstAirDate: "", genres: [], homepage: "", id: 1, inProduction: false, languages: [], lastAirDate: "", lastEpisodeToAir: TVEpisodeModel(), name: "serial 3", networks: [], numberOfEpisodes: 9, numberOfSeasons: 3, originCountry: [], originalLanguage: "", originalName: "", overview: "", popularity: 0, posterPath: nil, productionCompanies: [], seasons: [], status: "", tagline: "", type: "", voteAverage: 0, voteCount: 0, credits: nil)
    
}
