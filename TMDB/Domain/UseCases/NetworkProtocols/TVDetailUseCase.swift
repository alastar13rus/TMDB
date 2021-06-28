//
//  TVDetailUseCase.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation

public protocol TVDetailUseCase: UseCase {
    
    func details(mediaID: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage], completion: @escaping (Result<TVDetailModel, Error>) -> Void)
    func videos(mediaID: String, completion: @escaping (Result<VideoList, Error>) -> Void)
    func credits(mediaID: String, completion: @escaping (Result<CreditListResponse, Error>) -> Void)
    func aggregateCredits(mediaID: String, completion: @escaping (Result<TVAggregateCreditListResponse, Error>) -> Void)
    
}
