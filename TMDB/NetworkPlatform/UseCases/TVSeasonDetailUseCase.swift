//
//  TVSeasonDetailUseCase.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 19.05.2021.
//

import Foundation
import Domain

final class TVSeasonDetailUseCase: Domain.TVSeasonDetailUseCase {
    
    private let repository: TVSeasonDetailRepository
    private let api: Domain.TVSeasonDetailAPI

    init(_ repository: TVSeasonDetailRepository, _ api: Domain.TVSeasonDetailAPI) {
        self.repository = repository
        self.api = api
    }
    
    func details(mediaID: String,
                 seasonNumber: String,
                 appendToResponse: [AppendToResponse],
                 includeImageLanguage: [IncludeImageLanguage],
                 completion: @escaping (Result<TVSeasonDetailModel, Error>) -> Void) {
        
        let request = api.details(mediaID: mediaID,
                                  seasonNumber: seasonNumber,
                                  appendToResponse: appendToResponse,
                                  includeImageLanguage: includeImageLanguage)
        repository.fetchTVSeasonDetails(request, completion: completion)
    }
    
    func videos(mediaID: String,
                seasonNumber: String,
                completion: @escaping (Result<VideoList, Error>) -> Void) {
        
        let request = api.videos(mediaID: mediaID, seasonNumber: seasonNumber)
        repository.fetchTVSeasonVideos(request, completion: completion)
    }
    
    func aggregateCredits(mediaID: String,
                          seasonNumber: String,
                          completion: @escaping (Result<TVAggregateCreditListResponse, Error>) -> Void) {
        
        let request = api.aggregateCredits(mediaID: mediaID, seasonNumber: seasonNumber)
        repository.fetchTVSeasonAggregateCredits(request, completion: completion)
    }
    
}
