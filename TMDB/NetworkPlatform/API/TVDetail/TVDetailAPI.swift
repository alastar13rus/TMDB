//
//  TVDetailAPI.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

public final class TVDetailAPI {
    
    let apiKey: String
    let apiBaseURL: String

    init(_ config: (apiKey: String, apiBaseURL: String)) {
        self.apiKey = config.apiKey
        self.apiBaseURL = config.apiBaseURL
    }
}

//  MARK: - extension Domain.TVDetailAPI
extension TVDetailAPI: Domain.TVDetailAPI {

    public func details(mediaID: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage]) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/tv/" + mediaID
        
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
    
    public func aggregateCredits(mediaID: String) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/tv/" + mediaID + "/aggregate_credits"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
    public func credits(mediaID: String) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/tv/" + mediaID + "/credits"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
    public func videos(mediaID: String) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/tv/" + mediaID + "/videos"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }

    public func recommendations(mediaID: String) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/tv/" + mediaID + "/recommendations"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
}
