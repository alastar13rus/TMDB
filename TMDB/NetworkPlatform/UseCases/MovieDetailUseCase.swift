//
//  MovieDetailUseCase.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

final class MovieDetailUseCase: Domain.MovieDetailUseCase {
    
    private let repository: MovieDetailRepository
    private let api: MovieDetailAPI

    init(_ repository: MovieDetailRepository, _ api: MovieDetailAPI) {
        self.repository = repository
        self.api = api
    }
    
    func details(mediaID: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage], completion: @escaping (Result<MovieDetailModel, Error>) -> Void) {
        
        let request = api.details(mediaID: mediaID, appendToResponse: appendToResponse, includeImageLanguage: includeImageLanguage)
        repository.fetchMovieDetails(request, completion: completion)
    }
    
    func videos(mediaID: String, completion: @escaping (Result<VideoList, Error>) -> Void) {
        
        let request = api.videos(mediaID: mediaID)
        repository.fetchMovieVideos(request, completion: completion)
    }
    
    func credits(mediaID: String, completion: @escaping (Result<CreditListResponse, Error>) -> Void) {
        
        let request = api.credits(mediaID: mediaID)
        repository.fetchMovieCredits(request, completion: completion)
        
    }
}
