//
//  TVEpisodeDetailUseCase.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation

public protocol TVEpisodeDetailUseCase: UseCase {
    
    func details(mediaID: String,
                 seasonNumber: String,
                 episodeNumber: String,
                 appendToResponse: [AppendToResponse],
                 includeImageLanguage: [IncludeImageLanguage],
                 completion: @escaping (Result<TVEpisodeDetailModel, Error>) -> Void)
    
    func videos(mediaID: String,
                seasonNumber: String,
                episodeNumber: String,
                completion: @escaping (Result<VideoList, Error>) -> Void)
    
    func credits(mediaID: String,
                 seasonNumber: String,
                 episodeNumber: String,
                 completion: @escaping (Result<EpisodeCreditList, Error>) -> Void)
    
}
