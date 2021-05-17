//
//  TVAggregateCreditListResponse.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation

public struct TVAggregateCreditListResponse: CreditListResponseProtocol, Decodable {
    
    public typealias CastModelType = TVAggregateCastModel
    public typealias CrewModelType = TVAggregateCrewModel
    
    public let id: Int
    public let cast: [TVAggregateCastModel]
    public let crew: [TVAggregateCrewModel]
    
}
