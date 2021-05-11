//
//  PeopleDetailModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.04.2021.
//

import Foundation

struct PeopleDetailModel: Decodable {
    
    let birthday: String?
    let knownForDepartment: String
    let deathday: String?
    let id: Int
    let name: String
    let alsoKnownAs: [String]
    let gender: Int
    let biography: String
    let popularity: Float
    let placeOfBirth: String?
    let profilePath: String?
    let adult: Bool
    let imdb_id: String?
    let homepage: String?
    let combinedCredits: PeopleCombinedCreditList?
    let images: PeopleImageList?
    
    
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
