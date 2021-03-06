//
//  CreatorModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 08.04.2021.
//

import Foundation

public struct CreatorModel: Decodable {
    
    let id: Int
    let creditID: String
    let name: String
    let gender: Int?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case creditID = "credit_id"
        case name
        case gender
        case profilePath = "profile_path"
    }
    
}
