//
//  TVAggregateCastModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation
import RxDataSources

struct TVAggregateCastModel: Decodable {
    let adult: Bool
    let gender: Int
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Float
    let profilePath: String?
    let roles: [RoleModel]
    let totalEpisodeCount: Int
    let order: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case roles
        case totalEpisodeCount = "total_episode_count"
        case order
            
    }
    
    struct RoleModel: Decodable {
        let creditID: String
        let character: String
        let episodeCount: Int
        
        enum CodingKeys: String, CodingKey {
            case creditID = "credit_id"
            case character
            case episodeCount = "episode_count"
        }
    }
}

extension TVAggregateCastModel: IdentifiableType {
    var identity: Int { return id }
}

extension TVAggregateCastModel: Equatable {
    static func == (lhs: TVAggregateCastModel, rhs: TVAggregateCastModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}

extension TVAggregateCastModel: Comparable {
    static func < (lhs: TVAggregateCastModel, rhs: TVAggregateCastModel) -> Bool {
        return lhs.totalEpisodeCount < rhs.totalEpisodeCount
    }
}
