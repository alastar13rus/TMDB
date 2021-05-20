//
//  PeopleCombinedCreditList.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.04.2021.
//

import Foundation

public struct PeopleCombinedCreditList: Decodable {
    
    public let cast: [CastInMediaModel]
    public let crew: [CrewInMediaModel]
    
}

public struct CastInMediaModel: Decodable {
    
    public let id: Int
    public let originalLanguage: String
    public let episodeCount: Int?
    public let overview: String
    public let originCountry: [String]?
    public let originalName: String?
    public let genreIds: [Int]
    public let name: String?
    public let mediaType: MediaType
    public let posterPath: String?
    public let firstAirDate: String?
    public let voteAverage: Float
    public let voteCount: Int
    public let character: String?
    public let backdropPath: String?
    public let popularity: Float
    public let creditID: String
    public let originalTitle: String?
    public let video: Bool?
    public let releaseDate: String?
    public let title: String?
    public let adult: Bool?

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
        case firstAirDate = "first_air_date"
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

public struct CrewInMediaModel: Decodable {
    
    public let id: Int
    public let department: String
    public let originalLanguage: String
    public let episodeCount: Int?
    public let job: String
    public let overview: String
    public let originCountry: [String]?
    public let originalName: String?
    public let genreIds: [Int]
    public let name: String?
    public let mediaType: MediaType
    public let posterPath: String?
    public let firstAirDate: String?
    public let voteAverage: Float
    public let voteCount: Int
    public let backdropPath: String?
    public let popularity: Float
    public let creditID: String
    public let originalTitle: String?
    public let video: Bool?
    public let releaseDate: String?
    public let title: String?
    public let adult: Bool?
    
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
        case firstAirDate = "first_air_date"
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

public struct GroupedCreditInMediaModel: Decodable, Identifiable, Comparable {
    
    public let id: Int
    public let posterPath: String?
    public let mediaTitle: String
    public let mediaType: MediaType
    public let credit: String
    public let voteAverage: Float
    public let releaseDate: String?
    public let firstAirDate: String?
   
    public var releaseYear: String {
        switch mediaType {
        case .movie, .tv, .tvSeason, .tvEpisode:
            guard let releaseDate = releaseDate else { return "" }
            return "\(releaseDate.prefix(4))"
        }
    }
    
    public var identity: Int { return id }
    
//    MARK: - Init
    public init(id: Int, posterPath: String?, mediaTitle: String, mediaType: MediaType, credit: String, voteAverage: Float, releaseDate: String?, firstAirDate: String?) {
        self.id = id
        self.posterPath = posterPath
        self.mediaTitle = mediaTitle
        self.mediaType = mediaType
        self.credit = credit
        self.voteAverage = voteAverage
        self.releaseDate = releaseDate
        self.firstAirDate = firstAirDate
    }

    public static func < (lhs: GroupedCreditInMediaModel, rhs: GroupedCreditInMediaModel) -> Bool {
        return lhs.voteAverage < rhs.voteAverage
    }
}
