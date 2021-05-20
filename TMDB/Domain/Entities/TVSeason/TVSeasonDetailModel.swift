//
//  TVSeasonDetailModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 04.05.2021.
//

import Foundation

public struct TVSeasonDetailModel: Decodable {
    
    public let airDate: String?
    public let episodes: [TVEpisodeDetailModel]
    public let name: String
    public let overview: String
    public let id: Int
    public let posterPath: String?
    public let seasonNumber: Int
    public let aggregateCredits: TVAggregateCreditList?
    public let images: TVSeasonImageList?
    public let videos: VideoList?

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodes
        case name
        case overview
        case id
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case aggregateCredits = "aggregate_credits"
        case images
        case videos
    }
}
