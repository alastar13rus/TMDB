//
//  TVDetailUseCase.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation
import Domain

final class TVDetailUseCase: Domain.TVDetailUseCase {
    
    private let repository: TVDetailRepository
    private let api: TVDetailAPI

    init(_ repository: TVDetailRepository, _ api: TVDetailAPI) {
        self.repository = repository
        self.api = api
    }
    
    func details(mediaID: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage], completion: @escaping (Result<TVDetailModel, Error>) -> Void) {
        
        let request = api.details(mediaID: mediaID, appendToResponse: appendToResponse, includeImageLanguage: includeImageLanguage)
        repository.fetchTVDetails(request, completion: completion)
    }
    
    func videos(mediaID: String, completion: @escaping (Result<VideoList, Error>) -> Void) {
        
        let request = api.videos(mediaID: mediaID)
        repository.fetchTVVideos(request, completion: completion)
    }
    
    func credits(mediaID: String, completion: @escaping (Result<CreditListResponse, Error>) -> Void) {
        
        let request = api.credits(mediaID: mediaID)
        repository.fetchTVCredits(request, completion: completion)
        
    }
    
    func aggregateCredits(mediaID: String, completion: @escaping (Result<TVAggregateCreditListResponse, Error>) -> Void) {
        
        let request = api.aggregateCredits(mediaID: mediaID)
        repository.fetchTVAggregateCredits(request, completion: completion)
    }
    
}
