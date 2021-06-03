//
//  TVDetailNetwork.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

final class TVDetailNetwork {
    typealias Endpoint = Domain.Endpoint
    
    let network: NetworkAgent
    
    init(_ network: NetworkAgent) {
        self.network = network
    }
    
    public func fetchTVDetails(_ endpoint: Endpoint, completion: @escaping (Result<TVDetailModel, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchTVImages(_ endpoint: Endpoint, completion: @escaping (Result<MediaImageList, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchTVVideos(_ endpoint: Endpoint, completion: @escaping (Result<VideoList, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchTVCredits(_ endpoint: Endpoint, completion: @escaping (Result<CreditListResponse, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchTVAggregateCredits(_ endpoint: Endpoint, completion: @escaping (Result<TVAggregateCreditListResponse, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchRecommendations(_ endpoint: Endpoint, completion: @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
}
