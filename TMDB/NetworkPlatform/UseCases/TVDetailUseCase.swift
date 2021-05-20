//
//  TVDetailUseCase.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation
import Domain

final class TVDetailUseCase: Domain.TVDetailUseCase {
    
    private let network: TVDetailNetwork
    private let api: TVDetailAPI

    init(_ network: TVDetailNetwork, _ api: TVDetailAPI) {
        self.network = network
        self.api = api
    }
    
    func details(mediaID: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage], completion: @escaping (Result<TVDetailModel, Error>) -> Void) {
        
        let request = api.details(mediaID: mediaID, appendToResponse: appendToResponse, includeImageLanguage: includeImageLanguage)
        network.fetchTVDetails(request, completion: completion)
    }
    
    func videos(mediaID: String, completion: @escaping (Result<VideoList, Error>) -> Void) {
        
        let request = api.videos(mediaID: mediaID)
        network.fetchTVVideos(request, completion: completion)
    }
    
    func credits(mediaID: String, completion: @escaping (Result<CreditListResponse, Error>) -> Void) {
        
        let request = api.credits(mediaID: mediaID)
        network.fetchTVCredits(request, completion: completion)
        
    }
    
    func aggregateCredits(mediaID: String, completion: @escaping (Result<TVAggregateCreditListResponse, Error>) -> Void) {
        
        let request = api.aggregateCredits(mediaID: mediaID)
        network.fetchTVAggregateCredits(request, completion: completion)
    }
    
}
