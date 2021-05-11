//
//  MoviePosterWrapperCellViewModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 14.04.2021.
//

import XCTest
@testable import TMDB

class MoviePosterWrapperCellViewModelTest: XCTestCase {
    
    func test_init() {
        
        let moviePosterWrapperCellViewModel = MoviePosterWrapperCellViewModel(movieDetail)
        
        XCTAssertEqual(moviePosterWrapperCellViewModel.id, "1")
            XCTAssertEqual(moviePosterWrapperCellViewModel.title, "Title")
            XCTAssertEqual(moviePosterWrapperCellViewModel.tagline, "Winter is coming")
            XCTAssertEqual(moviePosterWrapperCellViewModel.voteAverage, 100)
        XCTAssertEqual(moviePosterWrapperCellViewModel.posterPath, "/yvmKPlTIi0xdcFQIFcQKQJcI63W.jpg")
        XCTAssertEqual(moviePosterWrapperCellViewModel.backdropPath,  "/iNh3BivHyg5sQRPP1KOkzguEX0H.jpg")
            XCTAssertEqual(moviePosterWrapperCellViewModel.releaseYear, "2020")
        
    }
    
    func test_releaseYear() {
        
        let moviePosterWrapperCellViewModel = MoviePosterWrapperCellViewModel(movieDetail)
        let moviePosterWrapperCellViewModel2 = MoviePosterWrapperCellViewModel(movieDetail2)

        XCTAssertEqual(moviePosterWrapperCellViewModel.releaseYear, "2020")
        XCTAssertEqual(moviePosterWrapperCellViewModel2.releaseYear, "")
    }
    
    func test_posterImageData() {
        let moviePosterWrapperCellViewModel = MoviePosterWrapperCellViewModel(movieDetail)
        var imageData: Data?

        let expectation = self.expectation(description: #function)
        
        
        moviePosterWrapperCellViewModel.posterImageData { (data) in
            imageData = data
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 6, handler: nil)
        XCTAssertNotNil(UIImage(data: imageData!))
        
    }
    
//    MARK: - Helpers
    let movieDetail = MovieDetailModel(adult: false, backdropPath: "/iNh3BivHyg5sQRPP1KOkzguEX0H.jpg", budget: 0, genres: [], homepage: "", id: 1, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: "/yvmKPlTIi0xdcFQIFcQKQJcI63W.jpg", productionCountries: [], productionCompanies: [], releaseDate: "2020-01-01", revenue: 0, runtime: 0, spokenLanguages: [], status: "", tagline: "Winter is coming", title: "Title", voteAverage: 10, voteCount: 0, video: false, credits: nil, recommendations: nil, similar: nil, images: nil, videos: nil)
    
    let movieDetail2 = MovieDetailModel(adult: false, backdropPath: "/iNh3BivHyg5sQRPP1KOkzguEX0H.jpg", budget: 0, genres: [], homepage: "", id: 1, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: "/yvmKPlTIi0xdcFQIFcQKQJcI63W.jpg", productionCountries: [], productionCompanies: [], releaseDate: nil, revenue: 0, runtime: 0, spokenLanguages: [], status: "", tagline: "Winter is coming", title: "Title", voteAverage: 10, voteCount: 0, video: false, credits: nil, recommendations: nil, similar: nil, images: nil, videos: nil)
    

}
