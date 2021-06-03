//
//  MovieListUseCase.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

final class MovieListUseCase: Domain.MovieListUseCase {
    
    private let network: MovieListNetwork
    private let api: MovieListAPI

    init(_ network: MovieListNetwork, _ api: MovieListAPI) {
        self.network = network
        self.api = api
    }
    
    func topRated(page: Int,
                  completion: @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void) {
        let request = api.topRated(page: page)
        network.fetchTopRatedMovies(request, completion: completion)
    }
    
    func popular(page: Int,
                 completion: @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void) {
        let request = api.popular(page: page)
        network.fetchPopularMovies(request, completion: completion)
    }
    
    func nowPlaying(page: Int,
                    completion: @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void) {
        let request = api.nowPlaying(page: page)
        network.fetchNowPlayingMovies(request, completion: completion)
    }
    
    func upcoming(page: Int,
                  completion: @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void) {
        let request = api.upcoming(page: page)
        network.fetchUpcomingMovies(request, completion: completion)
    }
    
    
}
