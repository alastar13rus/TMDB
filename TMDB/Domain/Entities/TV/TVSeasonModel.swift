//
//  TVSeasonModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 08.04.2021.
//

import Foundation

public struct TVSeasonModel: Decodable {
    public let airDate: String?
    public let episodeCount: Int
    public let id: Int
    public let name: String
    public let overview: String
    public let posterPath: String?
    public let seasonNumber: Int

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}
