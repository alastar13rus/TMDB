//
//  CreditListResponse.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.04.2021.
//

import Foundation

public protocol CreditListResponseProtocol {
    
    associatedtype CastModelType
    associatedtype CrewModelType
    
    var cast: [CastModelType] { get }
    var crew: [CrewModelType] { get }
}

public struct CreditListResponse: CreditListResponseProtocol, Decodable {
    
    public typealias CastModelType = CastModel
    public typealias CrewModelType = CrewModel
    
    public let cast: [CastModel]
    public let crew: [CrewModel]
    
}
