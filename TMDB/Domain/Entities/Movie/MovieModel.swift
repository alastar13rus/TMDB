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
    public var releaseDate: String?
    public var genreIds: [Int]
    public var id: Int
    public var originalTitle: String
    public var originalLanguage: String
    public var title: String
    public var backdropPath: String?
    public var popularity: Float?
    public var voteCount: Int
    public var video: Bool
    public var voteAverage: Float
    
    public init(
        posterPath: String?,
        adult: Bool,
        overview: String,
        releaseDate: String?,
        genreIds: [Int],
        id: Int,
        originalTitle: String,
        originalLanguage: String,
        title: String,
        backdropPath: String?,
        popularity: Float?,
        voteCount: Int,
        video: Bool,
        voteAverage: Float
    ) {
        self.posterPath = posterPath
        self.adult = adult
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIds = genreIds
        self.id = id
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.title = title
        self.backdropPath = backdropPath
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.voteAverage = voteAverage
    }
    
    public init(_ detailModel: MovieDetailModel)
    {
        self.posterPath = detailModel.posterPath
        self.adult = detailModel.adult
        self.overview = detailModel.overview
        self.releaseDate = detailModel.releaseDate
        self.genreIds = detailModel.genres.map { $0.id }
        self.id = detailModel.id
        self.originalTitle = detailModel.originalTitle
        self.originalLanguage = detailModel.originalLanguage
        self.title = detailModel.title
        self.backdropPath = detailModel.backdropPath
        self.popularity = detailModel.popularity
        self.voteCount = detailModel.voteCount
        self.video = detailModel.video
        self.voteAverage = detailModel.voteAverage
    }
    
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
