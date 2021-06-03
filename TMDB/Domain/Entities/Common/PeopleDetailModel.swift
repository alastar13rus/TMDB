//
//  PeopleDetailModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.04.2021.
//

import Foundation

public struct PeopleDetailModel: Decodable {
    
    public let birthday: String?
    public let knownForDepartment: String
    public let deathday: String?
    public let id: Int
    public let name: String
    public let alsoKnownAs: [String]
    public let gender: Int
    public let biography: String
    public let popularity: Float
    public let placeOfBirth: String?
    public let profilePath: String?
    public let adult: Bool
    public let imdb_id: String?
    public let homepage: String?
    public let combinedCredits: PeopleCombinedCreditList?
    public let images: PeopleImageList?
    
    
    enum CodingKeys: String, CodingKey {
        case birthday
        case knownForDepartment = "known_for_department"
        case deathday
        case id
        case name
        case alsoKnownAs = "also_known_as"
        case gender
        case biography
        case popularity
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
        case adult
        case imdb_id = "imdb_id"
        case homepage
        case combinedCredits = "combined_credits"
        case images = "images"
    }
}
