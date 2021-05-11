//
//  CreditListResponse.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.04.2021.
//

import Foundation

protocol CreditListResponseProtocol {
    
    associatedtype CastModelType
    associatedtype CrewModelType
    
    var id: Int { get }
    var cast: [CastModelType] { get }
    var crew: [CrewModelType] { get }
}

struct CreditListResponse: CreditListResponseProtocol, Decodable {
    
    typealias CastModelType = CastModel
    typealias CrewModelType = CrewModel
    
    let id: Int
    let cast: [CastModel]
    let crew: [CrewModel]
    
}
