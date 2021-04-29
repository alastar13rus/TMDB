//
//  TVDetailModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 08.04.2021.
//

import Foundation
import RxDataSources

struct TVDetailModel: TVDetailProtocol {
    
    typealias TVEpisodeProtocol = TVEpisodeModel
    typealias TVNetworkProtocol = TVNetworkModel
    typealias TVSeasonProtocol = TVSeasonModel
    
    let backdropPath: String?
    let createdBy: [CreatorModel]
    let episodeRunTime: [Int]
    let firstAirDate: String
    let genres: [GenreModel]
    let homepage: String?
    let id: Int
    let inProduction: Bool
    let languages: [LanguageModel]
    let lastAirDate: String
    let lastEpisodeToAir: TVEpisodeModel
    let name: String
    let networks: [TVNetworkModel]
    let numberOfEpisodes: Int
    let numberOfSeasons: Int
    let originCountry: [String]
    let originalLanguage: String
    let originalName: String
    let overview: String
    let popularity: Float
    let posterPath: String?
    let productionCompanies: [CompanyModel]
    let seasons: [TVSeasonModel]
    let status: String
    let tagline: String
    let type: String
    let voteAverage: Float
    let voteCount: Int
    let aggregateCredits: TVAggregateCreditList?
    let credits: MediaCreditList?
    let recommendations: MediaListResponse<TVModel>?
    let similar: MediaListResponse<TVModel>?
    let images: MediaImageList?
    
    enum CodingKeys: String, CodingKey {

        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres
        case homepage
        case id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
        case name
        case networks
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case seasons
        case status
        case tagline
        case type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case aggregateCredits = "aggregate_credits"
        case credits
        case recommendations
        case similar
        case images
    }
}

extension TVDetailModel: Equatable, Comparable {

    static func == (lhs: TVDetailModel, rhs: TVDetailModel) -> Bool {
        lhs.id == rhs.id
    }

    static func < (lhs: TVDetailModel, rhs: TVDetailModel) -> Bool {
        lhs.id < rhs.id
    }
}
