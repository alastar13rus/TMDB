//
//  PeopleDetailAPI.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 20.05.2021.
//

import Foundation
import Domain

public final class PeopleDetailAPI {
    
    let apiKey: String
    let apiBaseURL: String

    init(_ config: (apiKey: String, apiBaseURL: String)) {
        self.apiKey = config.apiKey
        self.apiBaseURL = config.apiBaseURL
    }
}

// MARK: - extension Domain.PeopleDetailAPI
extension PeopleDetailAPI: Domain.PeopleDetailAPI {
    public func details(personID: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage]) -> Domain.Endpoint {
        
        let method: HTTPMethod = .get
        let path = "/3/person/" + personID
        
        let appendToResponseString = appendToResponse.map { $0.rawValue }.joined(separator: ",")
        let includeImageLanguageString = includeImageLanguage.map { $0.rawValue }.joined(separator: ",")
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "append_to_response", value: appendToResponseString),
            URLQueryItem(name: "include_image_language", value: includeImageLanguageString),
            URLQueryItem(name: "language", value: Language.ru.rawValue),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        return NetworkPlatform.Endpoint(method: method, host: apiBaseURL, path: path, queryItems: queryItems)
    }
}
