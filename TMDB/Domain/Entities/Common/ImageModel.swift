//
//  ImageModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.04.2021.
//

import Foundation

public struct ImageModel: Decodable {
    public let aspectRatio: Float
    public let filePath: String
    public let height: Int
    public let voteAverage: Float
    public let voteCount: Int
    public let width: Int
    
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}

public struct PeopleImageList: Decodable {
    public let profiles: [ImageModel]
}

public struct MediaImageList: Decodable {
    public let backdrops: [ImageModel]
    public let posters: [ImageModel]
}

public struct TVSeasonImageList: Decodable {
    public let posters: [ImageModel]
}

public struct TVEpisodeImageList: Decodable {
    public let stills: [ImageModel]
}
