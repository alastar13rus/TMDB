//
//  TVAggregateCreditList.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation

struct TVAggregateCreditList: Decodable {
    let cast: [TVAggregateCastModel]
    let crew: [TVAggregateCrewModel]
}
