//
//  MediaListUseCase.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 16.05.2021.
//

import Foundation

public protocol MediaListUseCase: UseCase {
    
}

public protocol MovieListUseCase: MediaListUseCase {
    
    func topRated(page: Int,
                  completion: @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void)
    func popular(page: Int,
                 completion: @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void)
    func nowPlaying(page: Int,
                    completion: @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void)
    func upcoming(page: Int,
                  completion: @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void)
    
}

public protocol TVListUseCase: MediaListUseCase {
    
    func topRated(page: Int,
                  completion: @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void)
    func popular(page: Int,
                 completion: @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void)
    func onTheAir(page: Int,
                  completion: @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void)
    func airingToday(page: Int,
                     completion: @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void)
    
}
