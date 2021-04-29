//
//  TVAggregateCrewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation
import RxDataSources

struct TVAggregateCrewModel: Decodable {
    let adult: Bool
    let gender: Int
    let id: Int
    let knownForDepartment: String?
    let name: String
    let originalName: String
    let popularity: Float
    let profilePath: String?
    let jobs: [JobModel]
    let department: String
    let totalEpisodeCount: Int
    
    var departmentOrder: Int {
        Department.order(by: department)
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
    
    struct JobModel: Decodable {
        let creditID: String
        let job: String
        let episodeCount: Int
        
        enum CodingKeys: String, CodingKey {
            case creditID = "credit_id"
            case job
            case episodeCount = "episode_count"
        }
    }
}

extension TVAggregateCrewModel: IdentifiableType {
    var identity: Int { return id }
}

extension TVAggregateCrewModel: Equatable {
    static func == (lhs: TVAggregateCrewModel, rhs: TVAggregateCrewModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}

extension TVAggregateCrewModel: Comparable {
    static func < (lhs: TVAggregateCrewModel, rhs: TVAggregateCrewModel) -> Bool {
        return
            lhs.departmentOrder > rhs.departmentOrder &&
            lhs.totalEpisodeCount < rhs.totalEpisodeCount
    }
}
