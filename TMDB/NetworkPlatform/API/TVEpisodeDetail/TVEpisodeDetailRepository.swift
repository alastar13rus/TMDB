//
//  TVEpisodeDetailRepository.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation
import Domain

final class TVEpisodeDetailRepository {
    typealias Endpoint = Domain.Endpoint
    
    let network: NetworkAgent
    
    init(_ network: NetworkAgent) {
        self.network = network
    }
    
    public func fetchTVEpisodeDetails(_ endpoint: Endpoint, completion: @escaping (Result<TVEpisodeDetailModel, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchTVEpisodeImages(_ endpoint: Endpoint, completion: @escaping (Result<TVEpisodeDetailModel, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchTVEpisodeVideos(_ endpoint: Endpoint, completion: @escaping (Result<VideoList, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchTVEpisodeCredits(_ endpoint: Endpoint, completion: @escaping (Result<EpisodeCreditList, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
}
