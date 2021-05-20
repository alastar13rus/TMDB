//
//  TVAggregateCrewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation

public struct TVAggregateCrewModel: Decodable, Identifiable {
    public let adult: Bool
    public let gender: Int
    public let id: Int
    public let knownForDepartment: String?
    public let name: String
    public let originalName: String
    public let popularity: Float
    public let profilePath: String?
    public let jobs: [JobModel]
    public let department: String
    public let totalEpisodeCount: Int
    
    public var departmentOrder: Int {
        DepartmentHelper.order(by: department)
    }
    
    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case jobs
        case department
        case totalEpisodeCount = "total_episode_count"
    }
    
    public struct JobModel: Decodable {
        public let creditID: String
        public let job: String
        public let episodeCount: Int
        
        enum CodingKeys: String, CodingKey {
            case creditID = "credit_id"
            case job
            case episodeCount = "episode_count"
        }
    }
}

extension TVAggregateCrewModel: Equatable {
    public static func == (lhs: TVAggregateCrewModel, rhs: TVAggregateCrewModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension TVAggregateCrewModel: Comparable {
    public static func < (lhs: TVAggregateCrewModel, rhs: TVAggregateCrewModel) -> Bool {
        return
//            lhs.departmentOrder > rhs.departmentOrder &&
            lhs.totalEpisodeCount < rhs.totalEpisodeCount
    }
}
