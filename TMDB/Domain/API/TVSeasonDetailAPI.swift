//
//  TVSeasonDetailAPI.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation

public protocol TVSeasonDetailAPI: AnyObject {
    func details(mediaID: String,
                 seasonNumber: String,
                 appendToResponse: [AppendToResponse],
                 includeImageLanguage: [IncludeImageLanguage]) -> Endpoint
    
    func aggregateCredits(mediaID: String, seasonNumber: String) -> Endpoint
    func videos(mediaID: String, seasonNumber: String) -> Endpoint
}
