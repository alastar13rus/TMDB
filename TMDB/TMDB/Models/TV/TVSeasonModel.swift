//
//  TVSeasonModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 08.04.2021.
//

import Foundation

struct TVSeasonModel: Decodable {
    let airDate: String?
    let episodeCount: Int
    let id: Int
    let name: String
    let overview: String
    let posterPath: String?
    let seasonNumber: Int

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
