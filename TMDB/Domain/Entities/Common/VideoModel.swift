//
//  VideoModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation

public struct VideoModel: Decodable {
    public let id: String
    public let iso6391: String
    public let iso31661: String
    public let key: String
    public let name: String
    public let site: String
    public let size: Int
    public let type: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case iso6391 = "iso_639_1"
        case iso31661 = "iso_3166_1"
        case key
        case name
        case site
        case size
        case type
    }
}

public struct VideoList: Decodable {
    public let results: [VideoModel]
}
