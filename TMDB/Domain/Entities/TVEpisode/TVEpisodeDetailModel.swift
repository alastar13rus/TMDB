//
//  TVEpisodeDetailModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 08.04.2021.
//

import Foundation

public struct TVEpisodeDetailModel: Decodable {
    public let airDate: String?
    public let episodeNumber: Int
    public let id: Int
    public let name: String
    public let overview: String
    public let seasonNumber: Int
    public let stillPath: String?
    public let voteAverage: Float
    public let voteCount: Int
    public let credits: EpisodeCreditList?
    public let images: TVEpisodeImageList?
    public let videos: VideoList?

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
