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
    
    let tvEpisodeDetailModel = TVEpisodeDetailModel(airDate: nil, episodeNumber: 0, id: 1, name: "", overview: "", seasonNumber: 0, stillPath: nil, voteAverage: 0, voteCount: 0, credits: nil, images: nil, videos: nil)
    
    lazy var tvDetail = TVDetailModel(backdropPath: nil, createdBy: [], episodeRunTime: [60], firstAirDate: "", genres: [], homepage: "", id: 1, inProduction: false, languages: [], lastAirDate: "", lastEpisodeToAir: tvEpisodeDetailModel, name: "serial 1", networks: [], numberOfEpisodes: 9, numberOfSeasons: 3, originCountry: [], originalLanguage: "", originalName: "", overview: "", popularity: 0, posterPath: nil, productionCompanies: [], seasons: [], status: "", tagline: "", type: "", voteAverage: 0, voteCount: 0, aggregateCredits: nil, credits: nil, recommendations: nil, similar: nil, images: nil, videos: nil)
    
    lazy var tvDetail2 = TVDetailModel(backdropPath: nil, createdBy: [], episodeRunTime: [60], firstAirDate: "", genres: [], homepage: "", id: 2, inProduction: false, languages: [], lastAirDate: "", lastEpisodeToAir: tvEpisodeDetailModel, name: "serial 2", networks: [], numberOfEpisodes: 9, numberOfSeasons: 3, originCountry: [], originalLanguage: "", originalName: "", overview: "", popularity: 0, posterPath: nil, productionCompanies: [], seasons: [], status: "", tagline: "", type: "", voteAverage: 0, voteCount: 0, aggregateCredits: nil, credits: nil, recommendations: nil, similar: nil, images: nil, videos: nil)
    
    lazy var tvDetail3 = TVDetailModel(backdropPath: nil, createdBy: [], episodeRunTime: [60], firstAirDate: "", genres: [], homepage: "", id: 1, inProduction: false, languages: [], lastAirDate: "", lastEpisodeToAir: tvEpisodeDetailModel, name: "serial 3", networks: [], numberOfEpisodes: 9, numberOfSeasons: 3, originCountry: [], originalLanguage: "", originalName: "", overview: "", popularity: 0, posterPath: nil, productionCompanies: [], seasons: [], status: "", tagline: "", type: "", voteAverage: 0, voteCount: 0, aggregateCredits: nil, credits: nil, recommendations: nil, similar: nil, images: nil, videos: nil)
    
}
