//
//  VideoModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation

struct VideoModel: Decodable {
    let id: String
    let iso6391: String
    let iso31661: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
    
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

struct VideoList: Decodable {
    let results: [VideoModel]
}
