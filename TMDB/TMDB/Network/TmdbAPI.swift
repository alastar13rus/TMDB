//
//  TmdbAPI.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 15.03.2021.
//

import Foundation

enum TmdbAPI: API {
    
    static let apiKey = "fa49a4c641ab689908a24464f473c7a7"
    
    case movies(MovieEndpoint)
    
    var scheme: String {
        switch self {
        case .movies: return "https"
        }
    }
    
    var host: String {
        switch self {
        case .movies: return "api.tmdb.org"
        }
    }
    
    var method: String {
        switch self {
        case .movies: return "https"
        }
    }
    
    var path: String {
        switch self {
        case .movies(let endpoint):
            switch endpoint {
            case .topRated(_):
                return "/3/movie/top_rated"
            case .popular(_):
                return "/3/movie/popular"
            case .nowPlaying(_):
                return "/3/movie/now_playing"
            case .upcoming(_):
                return "/3/movie/upcoming"
            case .details(let mediaID):
                return "/3/movie/" + mediaID
            case .recommendations(let mediaID):
                return "/3/movie/" + mediaID + "/recommendations"
            case .credits(let mediaID):
                return "/3/movie/" + mediaID + "/credits"
            }
            
        }
        
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .movies(let endpoint):
            switch endpoint {
            case .topRated(let page),
                 .popular(let page),
                 .nowPlaying(let page),
                 .upcoming(let page):
                return [
                    URLQueryItem(name: "language", value: Language.ru.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey),
                    URLQueryItem(name: "page", value: String(page)),
                ]
                
            case .details(_):
                return [
                    URLQueryItem(name: "language", value: Language.ru.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey),
                ]
            case .recommendations:
                return [
                    URLQueryItem(name: "language", value: Language.ru.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey),
                ]
            case .credits:
                return [
                    URLQueryItem(name: "api_key", value: Self.apiKey),
                ]
            }
        }
    }
    
    
    
    enum MovieEndpoint {
        
        case topRated(page: Int)
        case popular(page: Int)
        case nowPlaying(page: Int)
        case upcoming(page: Int)
        case details(mediaID: String)
        case recommendations(mediaID: String)
        case credits(mediaID: String)
        
    }
    
    private enum Language: String {
        case ru = "ru-RU"
        case en = "en-US"
    }
    
}
