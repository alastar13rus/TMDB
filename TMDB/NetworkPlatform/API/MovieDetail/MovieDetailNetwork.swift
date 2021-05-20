//
//  MovieDetailNetwork.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

final class MovieDetailNetwork {
    typealias Endpoint = Domain.Endpoint
    
    let network: NetworkAgent
    
    init(_ network: NetworkAgent) {
        self.network = network
    }
    
    public func fetchMovieDetails(_ endpoint: Endpoint, completion: @escaping (Result<MovieDetailModel, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchMovieImages(_ endpoint: Endpoint, completion: @escaping (Result<MediaImageList, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchMovieVideos(_ endpoint: Endpoint, completion: @escaping (Result<VideoList, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchRecommendations(_ endpoint: Endpoint, completion: @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchMovieCredits(_ endpoint: Endpoint, completion: @escaping (Result<CreditListResponse, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
}
