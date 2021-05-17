//
//  TVAggregateCreditList.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation

public struct TVAggregateCreditList: Decodable {
    public let cast: [TVAggregateCastModel]
    public let crew: [TVAggregateCrewModel]
}
