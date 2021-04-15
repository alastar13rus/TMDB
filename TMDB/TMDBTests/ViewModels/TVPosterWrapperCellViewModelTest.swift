//
//  TVPosterWrapperCellViewModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 15.04.2021.
//

import XCTest
@testable import TMDB

class TVPosterWrapperCellViewModelTest: XCTestCase {
    
    func test_init() {
        
        let tvPosterWrapperCellViewModel = TVPosterWrapperCellViewModel(tvDetail)
        
        XCTAssertEqual(tvPosterWrapperCellViewModel.id, "1")
            XCTAssertEqual(tvPosterWrapperCellViewModel.title, "Title")
            XCTAssertEqual(tvPosterWrapperCellViewModel.tagline, "Winter is coming")
            XCTAssertEqual(tvPosterWrapperCellViewModel.voteAverage, 100)
        XCTAssertEqual(tvPosterWrapperCellViewModel.posterAbsolutePath, ImageURL.poster(.w500, "/yvmKPlTIi0xdcFQIFcQKQJcI63W.jpg").fullURL)
        XCTAssertEqual(tvPosterWrapperCellViewModel.backdropPath,  "/iNh3BivHyg5sQRPP1KOkzguEX0H.jpg")
            XCTAssertEqual(tvPosterWrapperCellViewModel.releaseYear, "2020 - 2022")
        
    }
    
    func test_releaseYear() {
        
        let tvPosterWrapperCellViewModel = TVPosterWrapperCellViewModel(tvDetail)
        let tvPosterWrapperCellViewModel2 = TVPosterWrapperCellViewModel(tvDetail2)

        XCTAssertEqual(tvPosterWrapperCellViewModel.releaseYear, "2020 - 2022")
        XCTAssertEqual(tvPosterWrapperCellViewModel2.releaseYear, "2021 - 2023")
    }
    
    func test_posterImageData() {
        let tvPosterWrapperCellViewModel = TVPosterWrapperCellViewModel(tvDetail)
        var imageData: Data?

        let expectation = self.expectation(description: #function)
        
        
        tvPosterWrapperCellViewModel.posterImageData { (data) in
            imageData = data
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNotNil(UIImage(data: imageData!))
        
    }
    
//    MARK: - Helpers
    let tvDetail = TVDetailModel(backdropPath: "/iNh3BivHyg5sQRPP1KOkzguEX0H.jpg", createdBy: [], episodeRunTime: [60], firstAirDate: "2020-01-01", genres: [], homepage: "", id: 1, inProduction: false, languages: [], lastAirDate: "2022-03-05", lastEpisodeToAir: TVEpisodeModel(), name: "Title", networks: [], numberOfEpisodes: 5, numberOfSeasons: 6, originCountry: [], originalLanguage: "", originalName: "", overview: "", popularity: 0, posterPath: "/yvmKPlTIi0xdcFQIFcQKQJcI63W.jpg", productionCompanies: [], seasons: [], status: "", tagline: "Winter is coming", type: "", voteAverage: 10, voteCount: 0, credits: nil)
    
    
    let tvDetail2 = TVDetailModel(backdropPath: "/iNh3BivHyg5sQRPP1KOkzguEX0H.jpg", createdBy: [], episodeRunTime: [60], firstAirDate: "2021-02-02", genres: [], homepage: "", id: 2, inProduction: false, languages: [], lastAirDate: "2023-07-13", lastEpisodeToAir: TVEpisodeModel(), name: "Title 2", networks: [], numberOfEpisodes: 5, numberOfSeasons: 6, originCountry: [], originalLanguage: "", originalName: "", overview: "", popularity: 0, posterPath: "/yvmKPlTIi0xdcFQIFcQKQJcI63W.jpg", productionCompanies: [], seasons: [], status: "", tagline: "Winter is coming", type: "", voteAverage: 10, voteCount: 0, credits: nil)
}
