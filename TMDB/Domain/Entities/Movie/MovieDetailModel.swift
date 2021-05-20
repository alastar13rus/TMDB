//
//  MovieDetailModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.04.2021.
//

import Foundation

public struct MovieDetailModel: MovieDetailProtocol {
    
    public let adult: Bool
    public let backdropPath: String?
    public let budget: Double
    public let genres: [GenreModel]
    public let homepage: String?
    public let id: Int
    public let originalLanguage: String
    public let originalTitle: String
    public let overview: String
    public let popularity: Float
    public let posterPath: String?
    public let productionCountries: [ProductionCountryModel]
    public let productionCompanies: [CompanyModel]
    public let releaseDate: String?
    public let revenue: Double
    public let runtime: Int?
    public let spokenLanguages: [LanguageModel]
    public let status: String
    public let tagline: String
    public let title: String
    public let voteAverage: Float
    public let voteCount: Int
    public let video: Bool
    public let credits: MediaCreditList?
    public let recommendations: MediaListResponse<MovieModel>?
    public let similar: MediaListResponse<MovieModel>?
    public let images: MediaImageList?
    public let videos: VideoList?

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
        case recommendations
        case similar
        case images
        case videos
    }
}

extension MovieDetailModel: Equatable, Comparable {

    public static func == (lhs: MovieDetailModel, rhs: MovieDetailModel) -> Bool {
        lhs.id == rhs.id
    }

    public static func < (lhs: MovieDetailModel, rhs: MovieDetailModel) -> Bool {
        lhs.id < rhs.id
    }
}
