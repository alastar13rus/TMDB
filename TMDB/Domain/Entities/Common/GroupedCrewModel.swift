//
//  GroupedCrewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 22.04.2021.
//

import Foundation

public struct GroupedCrewModel: Decodable, Identifiable {
    public let adult: Bool
    public let gender: Int
    public let id: Int
    public let knownForDepartment: String?
    public let name: String
    public let originalName: String
    public let popularity: Float
    public let profilePath: String?
    public let creditID: String
    public let jobs: String
    
//    MARK: - Init
    public init(adult: Bool, gender: Int, id: Int, knownForDepartment: String?, name: String, originalName: String, popularity: Float, profilePath: String?, creditID: String, jobs: String) {
        self.adult = adult
        self.gender = gender
        self.id = id
        self.knownForDepartment = knownForDepartment
        self.name = name
        self.originalName = originalName
        self.popularity = popularity
        self.profilePath = profilePath
        self.creditID = creditID
        self.jobs = jobs
    }
}

extension GroupedCrewModel: Comparable {
    public static func < (lhs: GroupedCrewModel, rhs: GroupedCrewModel) -> Bool {
        return lhs.popularity < rhs.popularity
    }
}
