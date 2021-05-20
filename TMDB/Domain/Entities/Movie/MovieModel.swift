//
//  MovieModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 08.04.2021.
//

import Foundation

public struct MovieModel: MovieProtocol {
    public var posterPath: String?
    public var adult: Bool
    public var overview: String
    public var releaseDate: String
    public var genreIds: [Int]
    public var id: Int
    public var originalTitle: String
    public var originalLanguage: String
    public var title: String
    public var backdropPath: String?
    public var popularity: Float
    public var voteCount: Int
    public var video: Bool
    public var voteAverage: Float
    
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
    public static func < (lhs: MovieModel, rhs: MovieModel) -> Bool {
        lhs.title < rhs.title
    }
}
