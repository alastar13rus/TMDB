//
//  SearchRepository.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import Foundation
import Domain

final class SearchRepository {
    typealias Endpoint = Domain.Endpoint
    
    let network: NetworkAgent
    
    init(_ network: NetworkAgent) {
        self.network = network
    }
    
    public func fetchFilterOptionListMediaByGenre(_ endpoint: Endpoint,
                                                  completion: @escaping (Result<GenreModelResponse, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchMediaListByYear<T: MediaProtocol>(_ endpoint: Endpoint,
                                                       completion: @escaping (Result<MediaListResponse<T>, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func fetchMediaListByGenre<T: MediaProtocol>(_ endpoint: Endpoint,
                                                        completion: @escaping (Result<MediaListResponse<T>, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
    
    public func multiSearch(_ endpoint: Endpoint,
                            completion: @escaping (Result<MultiSearchResponse, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
}
