//
//  MovieModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 08.04.2021.
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
