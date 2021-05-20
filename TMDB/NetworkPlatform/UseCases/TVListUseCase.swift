//
//  TVListUseCase.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

final class TVListUseCase: Domain.TVListUseCase {
    
    private let network: TVListNetwork
    private let api: TVListAPI

    init(_ network: TVListNetwork, _ api: TVListAPI) {
        self.network = network
        self.api = api
    }
    
    func topRated(page: Int,
                  completion: @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void) {
        let request = api.topRated(page: page)
        network.fetchTopRatedTVs(request, completion: completion)
    }
    
    func popular(page: Int,
                 completion: @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void) {
        let request = api.popular(page: page)
        network.fetchPopularTVs(request, completion: completion)
    }
    
    func onTheAir(page: Int,
                  completion: @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void) {
        let request = api.onTheAir(page: page)
        network.fetchOnTheAirTVs(request, completion: completion)
    }
    
    func airingToday(page: Int,
                     completion: @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void) {
        let request = api.airingToday(page: page)
        network.fetchAiringTodayTVs(request, completion: completion)
    }
    
    
}
