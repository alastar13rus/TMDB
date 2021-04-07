//
//  MediaModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 15.03.2021.
//

import Foundation

struct MovieModel: MovieProtocol {
    var posterPath: String?
    var adult: Bool
    var overview: String
    var releaseDate: String
    var genreIds: [Int]
    var id: Int
    var originalTitle: String
    var originalLanguage: String
    var title: String
    var backdropPath: String?
    var popularity: Float
    var voteCount: Int
    var video: Bool
    var voteAverage: Float
    
}

extension MovieModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case adult
        case overview
        case id
        case title
        case popularity
        case video
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
    }
}

extension MovieModel: Comparable {
    static func < (lhs: MovieModel, rhs: MovieModel) -> Bool {
        lhs.title < rhs.title
    }
}


struct TVModel: TVProtocol {
    
    let firstAirDate: String?
    let originCountry: [String]
    let name: String
    let originalName: String
    let id: Int
    let popularity: Float
    let voteCount: Int
    let posterPath: String?
    let backdropPath: String?
    let originalLanguage: String
    let genreIds: [Int]
    let voteAverage: Float
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalLanguage = "original_language"
        case popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case overview
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case name
        case originalName = "original_name"
    }
}

extension TVModel: Comparable {
    static func < (lhs: TVModel, rhs: TVModel) -> Bool {
        lhs.name < rhs.name
    }
}
