//
//  TVEpisodeDetailAPI.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation

public protocol TVEpisodeDetailAPI: AnyObject {
    
    func details(mediaID: String, seasonNumber: String, episodeNumber: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage]) -> Endpoint
    func aggregateCredits(mediaID: String, seasonNumber: String, episodeNumber: String) -> Endpoint
    func videos(mediaID: String, seasonNumber: String, episodeNumber: String) -> Endpoint
}
