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
    case tv(TVEndpoint)
    case people(PeopleEndpoint)
    case credit(CreditEndpoint)
    
    var scheme: String {
        switch self {
        case .movies, .tv, .people, .credit: return "https"
        }
    }
    
    var host: String {
        switch self {
        case .movies, .tv, .people, .credit: return "api.tmdb.org"
        }
    }
    
    var method: String {
        switch self {
        case .movies, .tv, .people, .credit: return "get"
        }
    }
    
    var path: String {
        switch self {
        case .movies(let endpoint):
            switch endpoint {
            case .topRated:
                return "/3/movie/top_rated"
            case .popular:
                return "/3/movie/popular"
            case .nowPlaying:
                return "/3/movie/now_playing"
            case .upcoming:
                return "/3/movie/upcoming"
            case .details(let mediaID, _):
                return "/3/movie/" + mediaID
            case .recommendations(let mediaID):
                return "/3/movie/" + mediaID + "/recommendations"
            case .credits(let mediaID):
                return "/3/movie/" + mediaID + "/credits"
            }
            
            
        case .tv(let endpoint):
            switch endpoint {
            case .topRated:
                return "/3/tv/top_rated"
            case .popular:
                return "/3/tv/popular"
            case .onTheAir:
                return "/3/tv/on_the_air"
            case .airingToday:
                return "/3/tv/airing_today"
            case .details(let mediaID, _):
                return "/3/tv/" + mediaID
            case .recommendations(let mediaID):
                return "/3/tv/" + mediaID + "/recommendations"
            case .credits(let mediaID):
                return "/3/tv/" + mediaID + "/credits"
            }
            
        case .people(let endpoint):
            switch endpoint {
            case .details(let personID, _):
                return "/3/person/" + personID
            }
            
        case .credit(let endpoint):
            switch endpoint {
            case .details(let creditID):
                return "/3/credit/" + creditID
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
                
            case .details(_, let appendToResponse):
                let appendString = appendToResponse.map { $0.rawValue }.joined(separator: ",")
                return [
                    URLQueryItem(name: "append_to_response", value: appendString),
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
                    URLQueryItem(name: "language", value: Language.ru.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey),
                ]
            }
            
            
        case .tv(let endpoint):
            // 6.
            switch endpoint {
            case .topRated(let page),
                 .popular(let page),
                 .onTheAir(let page),
                 .airingToday(let page):
                return [
                    URLQueryItem(name: "language", value: Language.ru.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey),
                    URLQueryItem(name: "page", value: String(page)),
                ]
                
            case .details(_, let appendToResponse):
                let appendString = appendToResponse.map { $0.rawValue }.joined(separator: ",")
                return [
                    URLQueryItem(name: "append_to_response", value: appendString),
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
                    URLQueryItem(name: "language", value: Language.ru.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey),
                ]
            }
            
        case .people(let endpoint):
            switch endpoint {
            case .details(_, let appendToResponse):
                let appendString = appendToResponse.map { $0.rawValue }.joined(separator: ",")
                return [
                    URLQueryItem(name: "append_to_response", value: appendString),
                    URLQueryItem(name: "language", value: Language.ru.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey)
                ]
            }
            
        case .credit(let endpoint):
            switch endpoint {
            case .details:
                return [
                    URLQueryItem(name: "language", value: Language.ru.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey)
                ]
            }
        }
    }
    
    enum MovieEndpoint {
        
        case topRated(page: Int)
        case popular(page: Int)
        case nowPlaying(page: Int)
        case upcoming(page: Int)
        case details(mediaID: String, appendToResponse: [AppendToResponse])
        case recommendations(mediaID: String)
        case credits(mediaID: String)
        
    }
    
    enum TVEndpoint {
        
        case topRated(page: Int)
        case popular(page: Int)
        case onTheAir(page: Int)
        case airingToday(page: Int)
        case details(mediaID: String, appendToResponse: [AppendToResponse])
        case recommendations(mediaID: String)
        case credits(mediaID: String)
        
    }
    
    enum PeopleEndpoint {
        case details(personID: String, appendToResponse: [AppendToResponse])
    }
    
    enum CreditEndpoint {
        case details(creditID: String)
    }
    
    enum AppendToResponse: String {
        case credits
        case video
        case images
        case combinedCredits = "combined_credits"
        case recommendations
    }
    
    
    private enum Language: String {
        case ru = "ru-RU"
        case en = "en-US"
    }
    
}
