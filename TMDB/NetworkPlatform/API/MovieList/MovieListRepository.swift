//
//  MovieListRepository.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

public protocol MediaListRepository: class {
    
}

final class MovieListRepository: MediaListRepository {
    
    typealias Endpoint = Domain.Endpoint
    
    let network: NetworkAgent
    
    init(_ network: NetworkAgent) {
        self.network = network
    }
    
    public func fetchTopRatedMovies<T: MediaProtocol>(_ endpoint: Endpoint, completion: @escaping (Result<MediaListResponse<T>, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }

    public func fetchPopularMovies(_ endpoint: Endpoint, completion: @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }

    public func fetchNowPlayingMovies(_ endpoint: Endpoint, completion: @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }

    public func fetchUpcomingMovies(_ endpoint: Endpoint, completion: @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
}
