//
//  TVListAPI.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

public final class TVListAPI {
    
    let apiKey: String
    let apiBaseURL: String

    init(_ config: (apiKey: String, apiBaseURL: String)) {
        self.apiKey = config.apiKey
        self.apiBaseURL = config.apiBaseURL
    }
}

//  MARK: - Domain.TVListAPI
extension TVListAPI: Domain.TVListAPI {
    
    public func topRated(page: Int) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/tv/top_rated"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
    public func popular(page: Int) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/tv/popular"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
    public func onTheAir(page: Int) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/tv/on_the_air"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
    public func airingToday(page: Int) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/tv/airing_today"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
}
