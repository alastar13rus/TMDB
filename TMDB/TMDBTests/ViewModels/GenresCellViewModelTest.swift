//
//  GenresCellViewModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 14.04.2021.
//

import XCTest
@testable import TMDB

class GenresCellViewModelTest: XCTestCase {
 
    func test_genresIsLowercasedStringFromArray() {
        
        let genreModelList: [GenreModel] = [
            GenreModel(id: 1, name: "Фантастика"),
            GenreModel(id: 1, name: "Драма"),
            GenreModel(id: 1, name: "Комедия"),
        ]
        
        let movieDetail = MovieDetailModel(adult: false, backdropPath: nil, budget: 0, genres: genreModelList, homepage: "", id: 0, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: nil, productionCountries: [], productionCompanies: [], releaseDate: nil, revenue: 0, runtime: 0, spokenLanguages: [], status: "", tagline: "", title: "", voteAverage: 0, voteCount: 0, video: false, credits: nil)
        
        let genresCellViewModel = GenresCellViewModel(movieDetail)
        
        XCTAssertEqual(genresCellViewModel.genres, "фантастика, драма, комедия")
    }
    
}
