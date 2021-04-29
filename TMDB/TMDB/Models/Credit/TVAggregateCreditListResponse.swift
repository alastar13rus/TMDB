//
//  TVAggregateCreditListResponse.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation

struct TVAggregateCreditListResponse: CreditListResponseProtocol, Decodable {
    
    typealias CastModelType = TVAggregateCastModel
    typealias CrewModelType = TVAggregateCrewModel
    
    let id: Int
    let cast: [TVAggregateCastModel]
    let crew: [TVAggregateCrewModel]
    
}
