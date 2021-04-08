//
//  TVModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 15.03.2021.
//

import Foundation

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
