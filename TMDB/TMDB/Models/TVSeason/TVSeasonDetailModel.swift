//
//  TVSeasonDetailModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 04.05.2021.
//

import Foundation

struct TVSeasonDetailModel: Decodable {
    
    let airDate: String?
    let episodes: [TVEpisodeDetailModel]
    let name: String
    let overview: String
    let id: Int
    let posterPath: String?
    let seasonNumber: Int
    let aggregateCredits: TVAggregateCreditList?
    let images: TVSeasonImageList?
    let videos: VideoList?

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
