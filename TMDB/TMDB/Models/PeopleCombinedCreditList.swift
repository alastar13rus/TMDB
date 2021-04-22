//
//  PeopleCombinedCreditList.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.04.2021.
//

import Foundation

struct PeopleCombinedCreditList: Decodable {
    
    let cast: [CastInMediaModel]
    let crew: [CrewInMediaModel]
    
}

struct CastInMediaModel: Decodable {
    
    let id: Int
    let originalLanguage: String
    let episodeCount: Int?
    let overview: String
    let originCountry: [String]?
    let originalName: String?
    let genreIds: [Int]
    let name: String?
    let mediaType: MediaType
    let posterPath: String?
    let first_air_date: String?
    let voteAverage: Float
    let voteCount: Int
    let character: String
    let backdropPath: String?
    let popularity: Float
    let creditID: String
    let originalTitle: String?
    let video: Bool?
    let releaseDate: String?
    let title: String?
    let adult: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case originalLanguage = "original_language"
        case episodeCount = "episode_count"
        case overview
        case originCountry = "origin_country"
        case originalName = "original_name"
        case genreIds = "genre_ids"
        case name
        case mediaType = "media_type"
        case posterPath = "poster_path"
        case first_air_date = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case character
        case backdropPath = "backdrop_path"
        case popularity
        case creditID = "credit_id"
        case originalTitle = "original_title"
        case video
        case releaseDate = "release_date"
        case title
        case adult
    }
    
}

enum MediaType: String, Decodable {
    case movie
    case tv
}

struct CrewInMediaModel: Decodable {
    
    let id: Int
    let department: String
    let originalLanguage: String
    let episodeCount: Int?
    let job: String
    let overview: String
    let originCountry: [String]?
    let originalName: String?
    let genreIds: [Int]
    let name: String?
    let mediaType: MediaType
    let posterPath: String?
    let first_air_date: String?
    let voteAverage: Float
    let voteCount: Int
    let backdropPath: String?
    let popularity: Float
    let creditID: String
    let originalTitle: String?
    let video: Bool?
    let releaseDate: String?
    let title: String?
    let adult: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case department
        case originalLanguage = "original_language"
        case episodeCount = "episode_count"
        case overview
        case job
        case originCountry = "origin_country"
        case originalName = "original_name"
        case genreIds = "genre_ids"
        case name
        case mediaType = "media_type"
        case posterPath = "poster_path"
        case first_air_date = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case backdropPath = "backdrop_path"
        case popularity
        case creditID = "credit_id"
        case originalTitle = "original_title"
        case video
        case releaseDate = "release_date"
        case title
        case adult
    }
}
/**

 
 */
