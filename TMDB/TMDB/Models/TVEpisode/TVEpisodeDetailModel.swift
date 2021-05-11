//
//  TVEpisodeDetailModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 08.04.2021.
//

import Foundation

struct TVEpisodeDetailModel: Decodable {
    let airDate: String?
    let episodeNumber: Int
    let id: Int
    let name: String
    let overview: String
    let seasonNumber: Int
    let stillPath: String?
    let voteAverage: Float
    let voteCount: Int
    let credits: EpisodeCreditList?
    let images: TVEpisodeImageList?
    let videos: VideoList?

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case id
        case name
        case overview
        case seasonNumber = "season_number"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case credits
        case images
        case videos
    }
}
