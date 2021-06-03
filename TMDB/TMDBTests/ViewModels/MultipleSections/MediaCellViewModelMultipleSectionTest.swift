//
//  MediaCellViewModelMultipleSectionTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 14.04.2021.
//

import XCTest
@testable import TMDB
@testable import Domain
@testable import NetworkPlatform

class MediaCellViewModelMultipleSectionTest: XCTestCase {
    
    func test_initMovieSection() {
        
        let sectionItem: MediaCellViewModelMultipleSection.SectionItem = .movie(vm: movieCellViewModel)
        let sut: MediaCellViewModelMultipleSection = .movieSection(title: Title.movie.rawValue, items: [sectionItem])
        
        XCTAssertEqual(sut.identity, Title.movie.rawValue)
        XCTAssertEqual(sut.title, Title.movie.rawValue)
        XCTAssertEqual(sectionItem.identity, "1_movie")
        XCTAssertEqual(sut.items.first, MediaCellViewModelMultipleSection.SectionItem.movie(vm: movieCellViewModel))
        
        let sut2 = MediaCellViewModelMultipleSection(original: sut, items: [sectionItem])
        
        XCTAssertEqual(sut2.identity, Title.movie.rawValue)
        XCTAssertEqual(sut2.title, Title.movie.rawValue)
        XCTAssertEqual(sectionItem.identity, "1_movie")
        XCTAssertEqual(
            sut2.items.first,
            MediaCellViewModelMultipleSection.SectionItem.movie(vm: movieCellViewModel))
    }
    
    func test_initTVSection() {
        
        let sectionItem: MediaCellViewModelMultipleSection.SectionItem = .tv(vm: tvCellViewModel)
        let sut: MediaCellViewModelMultipleSection = .tvSection(title: Title.tv.rawValue, items: [sectionItem])
        
        XCTAssertEqual(sut.identity, Title.tv.rawValue)
        XCTAssertEqual(sut.title, Title.tv.rawValue)
        XCTAssertEqual(sectionItem.identity, "2_tv")
        XCTAssertEqual(sut.items.first, MediaCellViewModelMultipleSection.SectionItem.tv(vm: tvCellViewModel))
        
        let sut2 = MediaCellViewModelMultipleSection(original: sut, items: [sectionItem])
        
        XCTAssertEqual(sut2.identity, Title.tv.rawValue)
        XCTAssertEqual(sut2.title, Title.tv.rawValue)
        XCTAssertEqual(sectionItem.identity, "2_tv")
        XCTAssertEqual(
            sut2.items.first,
            MediaCellViewModelMultipleSection.SectionItem.tv(vm: tvCellViewModel))
    }
    
//    MARK: - Helpers
    
    enum Title: String {
        case movie
        case tv
    }
    
    var movie: MovieModel {
        MovieModel(posterPath: nil, adult: false, overview: "", releaseDate: "", genreIds: [], id: 1, originalTitle: "", originalLanguage: "", title: "movie", backdropPath: nil, popularity: 0, voteCount: 0, video: false, voteAverage: 0)
    }
    
    var tv: TVModel {
        TVModel(firstAirDate: nil, originCountry: [], name: "tv", originalName: "", id: 2, popularity: 0, voteCount: 0, posterPath: nil, backdropPath: nil, originalLanguage: "", genreIds: [], voteAverage: 0, overview: "")
    }
    
    var movieCellViewModel: MediaCellViewModel { MediaCellViewModel(movie) }
    var tvCellViewModel: MediaCellViewModel { MediaCellViewModel(tv) }
    
}
