//
//  CreditDetailRepository.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

final class CreditDetailRepository {
    
    let network: NetworkAgent
    
    init(_ network: NetworkAgent) {
        self.network = network
    }
    
    public func fetchCreditDetails(_ endpoint: Endpoint, completion: @escaping (Result<CreditDetailModel, Error>) -> Void) {
        network.getItem(endpoint, completion: completion)
    }
}
