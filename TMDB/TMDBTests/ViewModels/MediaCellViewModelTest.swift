//
//  MediaCellViewModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 14.04.2021.
//

import XCTest
@testable import TMDB
@testable import Domain

class MediaCellViewModelTest: XCTestCase {
    
    func test_initWithMovieModel() {
        let mediaCellViewModel = MediaCellViewModel(movieModel)
        
        XCTAssertEqual(mediaCellViewModel.identity, "1")
        XCTAssertEqual(mediaCellViewModel.id, "1")
        XCTAssertEqual(mediaCellViewModel.title, "movieTitle")
        XCTAssertEqual(mediaCellViewModel.mediaType, .movie)
        XCTAssertEqual(mediaCellViewModel.overview, "movieOverview")
        XCTAssertEqual(mediaCellViewModel.voteAverage, 20)
        XCTAssertEqual(mediaCellViewModel.posterPath, "/yvmKPlTIi0xdcFQIFcQKQJcI63W.jpg")
        
    }
    
    func test_initWithTVModel() {
        let mediaCellViewModel = MediaCellViewModel(tvModel)
        
        XCTAssertEqual(mediaCellViewModel.identity, "2")
        XCTAssertEqual(mediaCellViewModel.id, "2")
        XCTAssertEqual(mediaCellViewModel.title, "tvName")
        XCTAssertEqual(mediaCellViewModel.mediaType, .tv)
        XCTAssertEqual(mediaCellViewModel.overview, "tvOverview")
        XCTAssertEqual(mediaCellViewModel.voteAverage, 50)
        XCTAssertEqual(mediaCellViewModel.posterPath, "/yvmKPlTIi0xdcFQIFcQKQJcI63W.jpg")
        
    }
    
    
//    MARK: - Helpers
    
    let movieModel = MovieModel(posterPath: "/yvmKPlTIi0xdcFQIFcQKQJcI63W.jpg", adult: false, overview: "movieOverview", releaseDate: "2020-01-01", genreIds: [], id: 1, originalTitle: "", originalLanguage: "", title: "movieTitle", backdropPath: nil, popularity: 3, voteCount: 1, video: false, voteAverage: 2)
    
    let tvModel = TVModel(firstAirDate: nil, originCountry: [], name: "tvName", originalName: "", id: 2, popularity: 3, voteCount: 0, posterPath: "/yvmKPlTIi0xdcFQIFcQKQJcI63W.jpg", backdropPath: nil, originalLanguage: "", genreIds: [], voteAverage: 5, overview: "tvOverview")

}
