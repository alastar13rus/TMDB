//
//  MovieListAPI.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

public final class MovieListAPI {
    
    let apiKey: String
    let apiBaseURL: String

    init(_ config: (apiKey: String, apiBaseURL: String)) {
        self.apiKey = config.apiKey
        self.apiBaseURL = config.apiBaseURL
    }
}
 
//  MARK: - extension Domain.MovieListAPI
extension MovieListAPI: Domain.MovieListAPI {
    
    public func topRated(page: Int) -> Domain.Endpoint {
        
        let method: Domain.HTTPMethod = .get
        let path = "/3/movie/top_rated"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Domain.Language.ru.rawValue),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
    public func popular(page: Int) -> Domain.Endpoint {
        
        let method: Domain.HTTPMethod = .get
        let path = "/3/movie/popular"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Domain.Language.ru.rawValue),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
    public func nowPlaying(page: Int) -> Domain.Endpoint {
        
        let method: Domain.HTTPMethod = .get
        let path = "/3/movie/now_playing"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Domain.Language.ru.rawValue),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
    public func upcoming(page: Int) -> Domain.Endpoint {
        
        let method: Domain.HTTPMethod = .get
        let path = "/3/movie/upcoming"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Domain.Language.ru.rawValue),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)   
    }
}
