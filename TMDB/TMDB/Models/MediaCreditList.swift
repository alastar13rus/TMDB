//
//  MediaCreditList.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import Foundation

struct MediaCreditList: Decodable {
    
    let cast: [CastModel]
    let crew: [CrewModel]
    
}
