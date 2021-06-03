//
//  TVModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 15.03.2021.
//

import Foundation

public struct TVModel: TVProtocol {
    
    public let firstAirDate: String?
    public let originCountry: [String]
    public let name: String
    public let originalName: String
    public let id: Int
    public let popularity: Float?
    public let voteCount: Int
    public let posterPath: String?
    public let backdropPath: String?
    public let originalLanguage: String
    public let genreIds: [Int]
    public let voteAverage: Float
    public let overview: String
    
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
    public static func < (lhs: TVModel, rhs: TVModel) -> Bool {
        lhs.name < rhs.name
    }
}
