//
//  ListNetwork.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

final class TVListRepository: MediaListRepository {
    typealias Endpoint = Domain.Endpoint
    
    let network: NetworkAgent
    
    init(_ network: NetworkAgent) {
        self.network = network
    }
    
    public func fetchTopRatedTVs(_ endpoint: Endpoint, completion: @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchPopularTVs(_ endpoint: Endpoint, completion: @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchOnTheAirTVs(_ endpoint: Endpoint, completion: @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchAiringTodayTVs(_ endpoint: Endpoint, completion: @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
}
