//
//  TVSeasonDetailUseCase.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation

public protocol TVSeasonDetailUseCase: UseCase {
    
    func details(mediaID: String,
                 seasonNumber: String,
                 appendToResponse: [AppendToResponse],
                 includeImageLanguage: [IncludeImageLanguage],
                 completion: @escaping (Result<TVSeasonDetailModel, Error>) -> Void)
    
    func videos(mediaID: String,
                seasonNumber: String,
                completion: @escaping (Result<VideoList, Error>) -> Void)
    
    func aggregateCredits(mediaID: String,
                          seasonNumber: String,
                          completion: @escaping (Result<TVAggregateCreditListResponse, Error>) -> Void)
}
