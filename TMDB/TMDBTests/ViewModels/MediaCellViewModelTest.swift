//
//  MediaCellViewModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 14.04.2021.
//

import XCTest
@testable import TMDB

class MediaCellViewModelTest: XCTestCase {
    
    func test_initWithMovieModel() {
        let mediaCellViewModel = MediaCellViewModel(movieModel)
        
        XCTAssertEqual(mediaCellViewModel.identity, "1")
        XCTAssertEqual(mediaCellViewModel.posterPath, "/yvmKPlTIi0xdcFQIFcQKQJcI63W.jpg")
        XCTAssertEqual(mediaCellViewModel.posterAbsolutePath, ImageURL.poster(.w154, "/yvmKPlTIi0xdcFQIFcQKQJcI63W.jpg").fullURL)
        
        let expectation = self.expectation(description: #function)
        
        var imageData: Data?
        mediaCellViewModel.posterImageData { (data) in
            imageData = data
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNotNil(UIImage(data: imageData!))
        
    }
    
    func test_initWithTVModel() {
        let mediaCellViewModel = MediaCellViewModel(tvModel)
        
        XCTAssertEqual(mediaCellViewModel.identity, "2")
        XCTAssertEqual(mediaCellViewModel.posterPath, "/yvmKPlTIi0xdcFQIFcQKQJcI63W.jpg")
        XCTAssertEqual(mediaCellViewModel.posterAbsolutePath, ImageURL.poster(.w154, "/yvmKPlTIi0xdcFQIFcQKQJcI63W.jpg").fullURL)
        
        let expectation = self.expectation(description: #function)
        
        var imageData: Data?
        mediaCellViewModel.posterImageData { (data) in
            imageData = data
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNotNil(UIImage(data: imageData!))
        
    }
    
    
//    MARK: - Helpers
    
    let movieModel = MovieModel(posterPath: "/yvmKPlTIi0xdcFQIFcQKQJcI63W.jpg", adult: false, overview: "", releaseDate: "2020-01-01", genreIds: [], id: 1, originalTitle: "", originalLanguage: "", title: "", backdropPath: nil, popularity: 0, voteCount: 0, video: false, voteAverage: 0)
    
    let tvModel = TVModel(firstAirDate: nil, originCountry: [], name: "", originalName: "", id: 2, popularity: 0, voteCount: 0, posterPath: "/yvmKPlTIi0xdcFQIFcQKQJcI63W.jpg", backdropPath: nil, originalLanguage: "", genreIds: [], voteAverage: 0, overview: "")

}
