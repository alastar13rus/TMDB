//
//  CastModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import Foundation

public struct CastModel: Decodable, Identifiable {
    public let adult: Bool
    public let gender: Int
    public let id: Int
    public let knownForDepartment: String
    public let name: String
    public let originalName: String
    public let popularity: Float
    public let profilePath: String?
    public let character: String
    public let creditID: String
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
        case character
        case creditID = "credit_id"
        case order
            
    }
}

extension CastModel: Comparable {
    public static func < (lhs: CastModel, rhs: CastModel) -> Bool {
        return lhs.order < rhs.order
    }
}
