//
//  TVCrewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import Foundation
import RxDataSources

struct CrewModel: Decodable, Hashable {
    let adult: Bool
    let gender: Int
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Float
    let profilePath: String?
    let creditID: String
    let department: String
    let job: String
    
    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case creditID = "credit_id"
        case department
        case job
    }
}

extension CrewModel: IdentifiableType {
    var identity: Int { return id }
}

extension CrewModel: Comparable {
    static func < (lhs: CrewModel, rhs: CrewModel) -> Bool {
        return lhs.popularity < rhs.popularity
    }
}
