//
//  MovieDetailAPI.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

public final class MovieDetailAPI {
    
    let apiKey: String
    let apiBaseURL: String

    init(_ config: (apiKey: String, apiBaseURL: String)) {
        self.apiKey = config.apiKey
        self.apiBaseURL = config.apiBaseURL
    }
}

// MARK: - extension Domain.MovieDetailAPI
extension MovieDetailAPI: Domain.MovieDetailAPI {
    
    public func details(mediaID: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage]) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/movie/" + mediaID
        
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
    
    public func credits(mediaID: String) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/movie/" + mediaID + "/credits"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
    public func images(mediaID: String) -> Domain.Endpoint {
        
        let method: Domain.HTTPMethod = .get
        let path = "/3/movie/" + mediaID + "/images"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
    public func videos(mediaID: String) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/movie/" + mediaID + "/videos"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
    public func recommendations(mediaID: String) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/movie/" + mediaID + "/recommendations"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
}
