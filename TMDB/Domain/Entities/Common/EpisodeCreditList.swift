//
//  EpisodeCreditList.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.05.2021.
//

import Foundation

public struct EpisodeCreditList: CreditListResponseProtocol, Decodable {
    
    public let cast: [CastModel]
    public let crew: [CrewModel]
    public let guestStars: [CastModel]
    
    enum CodingKeys: String, CodingKey {
        case cast
        case crew
        case guestStars = "guest_stars"
    }
    
}
