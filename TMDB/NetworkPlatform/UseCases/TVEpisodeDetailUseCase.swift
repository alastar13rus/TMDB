//
//  TVEpisodeDetailUseCase.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 19.05.2021.
//

import Foundation
import Domain

final class TVEpisodeDetailUseCase: Domain.TVEpisodeDetailUseCase {
    
    private let network: TVEpisodeDetailRepository
    private let api: TVEpisodeDetailAPI

    init(_ network: TVEpisodeDetailRepository, _ api: TVEpisodeDetailAPI) {
        self.network = network
        self.api = api
    }
    
    func details(mediaID: String,
                 seasonNumber: String,
                 episodeNumber: String,
                 appendToResponse: [AppendToResponse],
                 includeImageLanguage: [IncludeImageLanguage],
                 completion: @escaping (Result<TVEpisodeDetailModel, Error>) -> Void) {
        
        let request = api.details(mediaID: mediaID,
                                  seasonNumber: seasonNumber,
                                  episodeNumber: episodeNumber,
                                  appendToResponse: appendToResponse,
                                  includeImageLanguage: includeImageLanguage)
        network.fetchTVEpisodeDetails(request, completion: completion)
    }
    
    func videos(mediaID: String,
                seasonNumber: String,
                episodeNumber: String,
                completion: @escaping (Result<VideoList, Error>) -> Void) {
        
        let request = api.videos(mediaID: mediaID, seasonNumber: seasonNumber, episodeNumber: episodeNumber)
        network.fetchTVEpisodeVideos(request, completion: completion)
    }
    
    func credits(mediaID: String,
                          seasonNumber: String,
                          episodeNumber: String,
                          completion: @escaping (Result<EpisodeCreditList, Error>) -> Void) {
        
        let request = api.aggregateCredits(mediaID: mediaID, seasonNumber: seasonNumber, episodeNumber: episodeNumber)
        network.fetchTVEpisodeCredits(request, completion: completion)
    }
    
}
