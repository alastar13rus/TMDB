//
//  PeopleListNetwork.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import Foundation
import Domain

final class PeopleListNetwork {
    typealias Endpoint = Domain.Endpoint
    
    let network: NetworkAgent
    
    init(_ network: NetworkAgent) {
        self.network = network
    }
    
    public func fetchPopularPeoples(_ endpoint: Endpoint, completion: @escaping (Result<PeopleListResponse, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
}
