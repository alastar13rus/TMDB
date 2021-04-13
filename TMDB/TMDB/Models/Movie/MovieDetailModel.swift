//
//  MovieDetailModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.04.2021.
//

import Foundation

import RxDataSources

struct MovieDetailModel: MovieDetailProtocol {
    
    let adult: Bool
    let backdropPath: String?
    let budget: Double
    let genres: [GenreModel]
    let homepage: String
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Float
    let posterPath: String?
    let productionCountries: [ProductionCountryModel]
    let productionCompanies: [CompanyModel]
    let releaseDate: String?
    let revenue: Double
    let runtime: Int?
    let spokenLanguages: [LanguageModel]
    let status: String
    let tagline: String
    let title: String
    let voteAverage: Float
    let voteCount: Int
    let video: Bool
    let credits: MediaCreditList?
    
    enum CodingKeys: String, CodingKey {

        case adult
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case homepage
        case id
        case spokenLanguages = "spoken_languages"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCountries = "production_countries"
        case productionCompanies = "production_companies"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case status
        case tagline
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case video
        case credits
    }
}

extension MovieDetailModel: Equatable {

    static func == (lhs: MovieDetailModel, rhs: MovieDetailModel) -> Bool {
        lhs.id == rhs.id
    }

    static func < (lhs: MovieDetailModel, rhs: MovieDetailModel) -> Bool {
        lhs.id < rhs.id
    }
}
