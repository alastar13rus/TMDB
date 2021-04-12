//
//  TVCreditListResponse.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import Foundation

struct TVCreditList: Decodable {
    
    let cast: [TVCastModel]
    let crew: [TVCrewModel]
    
}
