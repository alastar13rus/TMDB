//
//  PeopleDetailUseCase.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation
import Domain

final class PeopleDetailUseCase: Domain.PeopleDetailUseCase {
    
    private let repository: PeopleDetailRepository
    private let api: PeopleDetailAPI

    init(_ repository: PeopleDetailRepository, _ api: PeopleDetailAPI) {
        self.repository = repository
        self.api = api
    }
    
    func details(personID: String,
                 appendToResponse: [AppendToResponse],
                 includeImageLanguage: [IncludeImageLanguage],
                 completion: @escaping (Result<PeopleDetailModel, Error>) -> Void) {
        
        let endpoint = api.details(personID: personID,
                                  appendToResponse: appendToResponse,
                                  includeImageLanguage: includeImageLanguage)
        
        repository.fetchPeopleDetails(endpoint, completion: completion)
    }
    
}
