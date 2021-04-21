//
//  PeopleImageList.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.04.2021.
//

import Foundation

struct PeopleImageList: Decodable {
    
    let profiles: [ImageModel]
    
    struct ImageModel: Decodable {
        let aspectRatio: Float
        let filePath: String
        let height: Int
        let voteAverage: Float
        let voteCount: Int
        let width: Int
        
        enum CodingKeys: String, CodingKey {
            case aspectRatio = "aspect_ratio"
            case filePath = "file_path"
            case height
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
            case width
        }
    }
    
}
