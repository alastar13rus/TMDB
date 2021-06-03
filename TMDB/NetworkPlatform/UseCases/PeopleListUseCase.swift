//
//  PeopleListUseCase.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import Foundation
import Domain

final class PeopleListUseCase: Domain.PeopleListUseCase {
    
    private let network: PeopleListNetwork
    private let api: PeopleListAPI

    init(_ network: PeopleListNetwork, _ api: PeopleListAPI) {
        self.network = network
        self.api = api
    }
    
    func popular(_ completion: @escaping (Result<PeopleListResponse, Error>) -> Void) {
        
        let request = api.popular()
        network.fetchPopularPeoples(request, completion: completion)
    }
}
