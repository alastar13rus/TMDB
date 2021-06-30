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
    
    public init(
        firstAirDate: String?,
        originCountry: [String],
        name: String,
        originalName: String,
        id: Int,
        popularity: Float?,
        voteCount: Int,
        posterPath: String?,
        backdropPath: String?,
        originalLanguage: String,
        genreIds: [Int],
        voteAverage: Float,
        overview: String
    ) {
        self.firstAirDate = firstAirDate
        self.originCountry = originCountry
        self.name = name
        self.originalName = originalName
        self.id = id
        self.popularity = popularity
        self.voteCount = voteCount
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.originalLanguage = originalLanguage
        self.genreIds = genreIds
        self.voteAverage = voteAverage
        self.overview = overview
    }
    
    public init(_ detailModel: TVDetailModel) {
        self.firstAirDate = detailModel.firstAirDate
        self.originCountry = detailModel.originCountry
        self.name = detailModel.name
        self.originalName = detailModel.originalName
        self.id = detailModel.id
        self.popularity = detailModel.popularity
        self.voteCount = detailModel.voteCount
        self.posterPath = detailModel.posterPath
        self.backdropPath = detailModel.backdropPath
        self.originalLanguage = detailModel.originalLanguage
        self.genreIds = detailModel.genres.map { $0.id }
        self.voteAverage = detailModel.voteAverage
        self.overview = detailModel.overview
    }
    
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
