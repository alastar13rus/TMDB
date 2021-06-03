//
//  PeopleListAPI.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import Foundation
import Domain

public final class PeopleListAPI {
    
    let apiKey: String
    let apiBaseURL: String

    init(_ config: (apiKey: String, apiBaseURL: String)) {
        self.apiKey = config.apiKey
        self.apiBaseURL = config.apiBaseURL
    }
}

//  MARK: - extension Domain.PeopleListAPI
extension PeopleListAPI: Domain.PeopleListAPI {
    public func popular() -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/person/popular"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return NetworkPlatform.Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
}
