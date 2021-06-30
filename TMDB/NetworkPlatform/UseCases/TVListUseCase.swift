//
//  TVListUseCase.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

final class TVListUseCase: Domain.TVListUseCase {
    
    private let repository: TVListRepository
    private let api: Domain.TVListAPI

    init(_ repository: TVListRepository, _ api: Domain.TVListAPI) {
        self.repository = repository
        self.api = api
    }
    
    func topRated(page: Int,
                  completion: @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void) {
        let request = api.topRated(page: page)
        repository.fetchTopRatedTVs(request, completion: completion)
    }
    
    func popular(page: Int,
                 completion: @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void) {
        let request = api.popular(page: page)
        repository.fetchPopularTVs(request, completion: completion)
    }
    
    func onTheAir(page: Int,
                  completion: @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void) {
        let request = api.onTheAir(page: page)
        repository.fetchOnTheAirTVs(request, completion: completion)
    }
    
    func airingToday(page: Int,
                     completion: @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void) {
        let request = api.airingToday(page: page)
        repository.fetchAiringTodayTVs(request, completion: completion)
    }
    
}
