//
//  TVSeasonDetailNetwork.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation
import Domain

final class TVSeasonDetailNetwork {
    typealias Endpoint = Domain.Endpoint
    
    let network: NetworkAgent
    
    init(_ network: NetworkAgent) {
        self.network = network
    }
    
    public func fetchTVSeasonDetails(_ endpoint: Endpoint, completion: @escaping (Result<TVSeasonDetailModel, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchTVSeasonImages(_ endpoint: Endpoint, completion: @escaping (Result<TVSeasonDetailModel, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchTVSeasonVideos(_ endpoint: Endpoint, completion: @escaping (Result<VideoList, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchTVSeasonCredits(_ endpoint: Endpoint, completion: @escaping (Result<CreditListResponse, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchTVSeasonAggregateCredits(_ endpoint: Endpoint, completion: @escaping (Result<TVAggregateCreditListResponse, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
}
