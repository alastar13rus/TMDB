//
//  TVDetailModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 08.04.2021.
//

import Foundation

public struct TVDetailModel: TVDetailProtocol {
    
    public typealias TVEpisodeProtocol = TVEpisodeDetailModel
    public typealias TVNetworkProtocol = TVNetworkModel
    public typealias TVSeasonProtocol = TVSeasonModel
    
    public let backdropPath: String?
    public let createdBy: [CreatorModel]
    public let episodeRunTime: [Int]
    public let firstAirDate: String
    public let genres: [GenreModel]
    public let homepage: String?
    public let id: Int
    public let inProduction: Bool
    public let languages: [LanguageModel]
    public let lastAirDate: String
    public let lastEpisodeToAir: TVEpisodeDetailModel
    public let name: String
    public let networks: [TVNetworkModel]
    public let numberOfEpisodes: Int
    public let numberOfSeasons: Int
    public let originCountry: [String]
    public let originalLanguage: String
    public let originalName: String
    public let overview: String
    public let popularity: Float
    public let posterPath: String?
    public let productionCompanies: [CompanyModel]
    public let seasons: [TVSeasonModel]
    public let status: String
    public let tagline: String
    public let type: String
    public let voteAverage: Float
    public let voteCount: Int
    public let aggregateCredits: TVAggregateCreditList?
    public let credits: MediaCreditList?
    public let recommendations: MediaListResponse<TVModel>?
    public let similar: MediaListResponse<TVModel>?
    public let images: MediaImageList?
    public let videos: VideoList?
    
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
        case videos
    }
}

extension TVDetailModel: Equatable, Comparable {

    public static func == (lhs: TVDetailModel, rhs: TVDetailModel) -> Bool {
        lhs.id == rhs.id
    }

    public static func < (lhs: TVDetailModel, rhs: TVDetailModel) -> Bool {
        lhs.id < rhs.id
    }
}
