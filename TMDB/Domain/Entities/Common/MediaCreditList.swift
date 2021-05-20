//
//  MediaCreditList.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import Foundation

public struct MediaCreditList: Decodable {
    
    public let cast: [CastModel]
    public let crew: [CrewModel]
    
}
