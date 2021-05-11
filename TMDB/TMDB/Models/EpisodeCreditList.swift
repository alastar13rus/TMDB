//
//  EpisodeCreditList.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.05.2021.
//

import Foundation

struct EpisodeCreditList: Decodable {
    
    let cast: [CastModel]
    let crew: [CrewModel]
    let guestStars: [CastModel]
    
    enum CodingKeys: String, CodingKey {
        case cast
        case crew
        case guestStars = "guest_stars"
    }
    
}
