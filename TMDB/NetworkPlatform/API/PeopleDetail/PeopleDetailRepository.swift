//
//  PeopleDetailRepository.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

final class PeopleDetailRepository {
    typealias Endpoint = Domain.Endpoint
    
    let network: NetworkAgent
    
    init(_ network: NetworkAgent) {
        self.network = network
    }
    
    public func fetchPeopleDetails(_ endpoint: Endpoint, completion: @escaping (Result<PeopleDetailModel, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
}
