//
//  MovieListUseCase.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

final class MovieListUseCase: Domain.MovieListUseCase {
    
    private let repository: MovieListRepository
    private let api: MovieListAPI

    init(_ repository: MovieListRepository, _ api: MovieListAPI) {
        self.repository = repository
        self.api = api
    }
    
    func topRated(page: Int,
                  completion: @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void) {
        let request = api.topRated(page: page)
        repository.fetchTopRatedMovies(request, completion: completion)
    }
    
    func popular(page: Int,
                 completion: @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void) {
        let request = api.popular(page: page)
        repository.fetchPopularMovies(request, completion: completion)
    }
    
    func nowPlaying(page: Int,
                    completion: @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void) {
        let request = api.nowPlaying(page: page)
        repository.fetchNowPlayingMovies(request, completion: completion)
    }
    
    func upcoming(page: Int,
                  completion: @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void) {
        let request = api.upcoming(page: page)
        repository.fetchUpcomingMovies(request, completion: completion)
    }
    
    
}
