//
//  MovieDetailUseCase.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 16.05.2021.
//

import Foundation

public protocol MovieDetailUseCase: UseCase {
    
    func details(mediaID: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage], completion: @escaping (Result<MovieDetailModel, Error>) -> Void)
    func videos(mediaID: String, completion: @escaping (Result<VideoList, Error>) -> Void)
    func credits(mediaID: String, completion: @escaping (Result<CreditListResponse, Error>) -> Void)
}
