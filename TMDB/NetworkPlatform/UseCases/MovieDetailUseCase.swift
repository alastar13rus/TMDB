//
//  MovieDetailUseCase.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

final class MovieDetailUseCase: Domain.MovieDetailUseCase {
    
    private let network: MovieDetailNetwork
    private let api: MovieDetailAPI

    init(_ network: MovieDetailNetwork, _ api: MovieDetailAPI) {
        self.network = network
        self.api = api
    }
    
    func details(mediaID: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage], completion: @escaping (Result<MovieDetailModel, Error>) -> Void) {
        
        let request = api.details(mediaID: mediaID, appendToResponse: appendToResponse, includeImageLanguage: includeImageLanguage)
        network.fetchMovieDetails(request, completion: completion)
    }
    
    func videos(mediaID: String, completion: @escaping (Result<VideoList, Error>) -> Void) {
        
        let request = api.videos(mediaID: mediaID)
        network.fetchMovieVideos(request, completion: completion)
    }
    
    func credits(mediaID: String, completion: @escaping (Result<CreditListResponse, Error>) -> Void) {
        
        let request = api.credits(mediaID: mediaID)
        network.fetchMovieCredits(request, completion: completion)
        
    }
}
