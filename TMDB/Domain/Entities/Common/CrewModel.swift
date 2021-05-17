//
//  TVCrewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import Foundation

public struct CrewModel: Decodable, Identifiable {
    public let adult: Bool
    public let gender: Int
    public let id: Int
    public let knownForDepartment: String?
    public let name: String
    public let originalName: String
    public let popularity: Float
    public let profilePath: String?
    public let creditID: String
    public let department: String
    public let job: String
    
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
        case creditID = "credit_id"
        case department
        case job
    }
}

extension CrewModel: Comparable {
    public static func < (lhs: CrewModel, rhs: CrewModel) -> Bool {
        return lhs.departmentOrder > rhs.departmentOrder
    }
}
