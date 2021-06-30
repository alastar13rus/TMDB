//
//  SearchAPI.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import Foundation
import Domain

public final class SearchAPI {
    
    let apiKey: String
    let apiBaseURL: String

    init(_ config: (apiKey: String, apiBaseURL: String)) {
        self.apiKey = config.apiKey
        self.apiBaseURL = config.apiBaseURL
    }
}

// MARK: - extension Domain.SearchAPI
extension SearchAPI: Domain.SearchAPI {
    
    public func mediaListByYear(_ year: String, mediaType: MediaType, page: Int) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/discover/" + mediaType.rawValue
        
        var yearKey: String {
            if case .movie = mediaType { return "year" } else { return "first_air_date_year" }
        }
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: yearKey, value: year),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return NetworkPlatform.Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
    public func mediaListByGenre(_ genreID: String, mediaType: MediaType, page: Int) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/discover/" + mediaType.rawValue
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "with_genres", value: genreID),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return NetworkPlatform.Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
    public func mediaGenreList(mediaType: MediaType) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/genre/" + mediaType.rawValue + "/list"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return NetworkPlatform.Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
    public func multiSearch(_ query: String, page: Int) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/search/multi"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return NetworkPlatform.Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
    
}
