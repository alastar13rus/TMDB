//
//  TVEpisodeDetailAPI.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation
import Domain

public final class TVEpisodeDetailRequest: Domain.TVEpisodeDetailAPI {
    
    public func details(mediaID: String, seasonNumber: String, episodeNumber: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage]) -> Domain.Request {
        
        let method: HTTPMethod = .get
        let endpoint = "/3/tv/" + mediaID + "/season/" + seasonNumber + "/episode/" + episodeNumber
        
        let appendToResponseString = appendToResponse.map { $0.rawValue }.joined(separator: ",")
        let includeImageLanguageString = includeImageLanguage.map { $0.rawValue }.joined(separator: ",")
        
        let parameters: [URLQueryItem] = [
            URLQueryItem(name: "append_to_response", value: appendToResponseString),
            URLQueryItem(name: "include_image_language", value: includeImageLanguageString),
            URLQueryItem(name: "language", value: Language.ru.rawValue)
        ]
        
        return Request(method: method, endpoint: endpoint, parameters: parameters)
    }
    
    public func credits(mediaID: String, seasonNumber: String, episodeNumber: String) -> Domain.Request {
        
        let method: HTTPMethod = .get
        let endpoint = "/3/tv/" + mediaID + "/season/" + seasonNumber + "/episode/" + episodeNumber + "/credits"
        
        let parameters: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Language.ru.rawValue)
        ]
        
        return Request(method: method, endpoint: endpoint, parameters: parameters)
    }
    
    public func videos(mediaID: String, seasonNumber: String, episodeNumber: String) -> Domain.Request {
        
        let method: HTTPMethod = .get
        let endpoint = "/3/tv/" + mediaID + "/season/" + seasonNumber + "/episode/" + episodeNumber + "/videos"
        
        let parameters: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Language.ru.rawValue)
        ]
        
        return Request(method: method, endpoint: endpoint, parameters: parameters)
    }
    
}
