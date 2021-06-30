//
//  PeopleListUseCase.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import Foundation
import Domain

final class PeopleListUseCase: Domain.PeopleListUseCase {
    
    private let repository: PeopleListRepository
    private let api: Domain.PeopleListAPI

    init(_ repository: PeopleListRepository, _ api: Domain.PeopleListAPI) {
        self.repository = repository
        self.api = api
    }
    
    func popular(_ completion: @escaping (Result<PeopleListResponse, Error>) -> Void) {
        
        let request = api.popular()
        repository.fetchPopularPeoples(request, completion: completion)
    }
}
