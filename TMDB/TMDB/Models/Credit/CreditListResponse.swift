//
//  CreditListResponse.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.04.2021.
//

import Foundation

struct CreditListResponse: Decodable {
    
    let id: Int
    let cast: [CastModel]
    let crew: [CrewModel]
    
}
