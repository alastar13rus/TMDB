//
//  TVEpisodeDetailAPI.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation
import Domain

public final class TVEpisodeDetailAPI {
    
    let apiKey: String
    let apiBaseURL: String

    init(_ config: (apiKey: String, apiBaseURL: String)) {
        self.apiKey = config.apiKey
        self.apiBaseURL = config.apiBaseURL
    }
}

// MARK: - extension Domain.TVEpisodeDetailAPI
extension TVEpisodeDetailAPI: Domain.TVEpisodeDetailAPI {
    
    public func details(mediaID: String,
                        seasonNumber: String,
                        episodeNumber: String,
                        appendToResponse: [AppendToResponse],
                        includeImageLanguage: [IncludeImageLanguage]) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/tv/" + mediaID + "/season/" + seasonNumber + "/episode/" + episodeNumber
        
        let appendToResponseString = appendToResponse.map { $0.rawValue }.joined(separator: ",")
        let includeImageLanguageString = includeImageLanguage.map { $0.rawValue }.joined(separator: ",")
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "append_to_response", value: appendToResponseString),
            URLQueryItem(name: "include_image_language", value: includeImageLanguageString),
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
        
    }
    
    public func aggregateCredits(mediaID: String, seasonNumber: String, episodeNumber: String) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/tv/" + mediaID + "/season/" + seasonNumber + "/episode/" + episodeNumber + "/aggregate_credits"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
    public func videos(mediaID: String, seasonNumber: String, episodeNumber: String) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/tv/" + mediaID + "/season/" + seasonNumber + "/episode/" + episodeNumber + "/videos"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
}
