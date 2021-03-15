//
//  MovieModel.swift
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
    var popularity: Int
    var voteCount: Int
    var video: Bool
    var voteAverage: Int
    
}

extension MovieModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case adult
        case overview
        case genreIds
        case id
        case title
        case popularity
        case video
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
    }
}
