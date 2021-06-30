//
//  TVAggregateCastModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation

public struct TVAggregateCastModel: Decodable {
    public let adult: Bool
    public let gender: Int
    public let id: Int
    public let knownForDepartment: String
    public let name: String
    public let originalName: String
    public let popularity: Float
    public let profilePath: String?
    public let roles: [RoleModel]
    public let totalEpisodeCount: Int
    public let order: Int
    
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
}

public struct RoleModel: Decodable {
    public let creditID: String
    public let character: String
    public let episodeCount: Int
    
    enum CodingKeys: String, CodingKey {
        case creditID = "credit_id"
        case character
        case episodeCount = "episode_count"
    }
}

extension TVAggregateCastModel: Equatable {
    public static func == (lhs: TVAggregateCastModel, rhs: TVAggregateCastModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension TVAggregateCastModel: Comparable {
    public static func < (lhs: TVAggregateCastModel, rhs: TVAggregateCastModel) -> Bool {
        return lhs.totalEpisodeCount < rhs.totalEpisodeCount
    }
}
