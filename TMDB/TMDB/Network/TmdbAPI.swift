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
            case .details(let mediaID, _, _):
                return "/3/movie/" + mediaID
            case .recommendations(let mediaID):
                return "/3/movie/" + mediaID + "/recommendations"
            case .credits(let mediaID):
                return "/3/movie/" + mediaID + "/credits"
            case .videos(let mediaID):
                return "/3/movie/" + mediaID + "/videos"
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
            case .details(let mediaID, _, _):
                return "/3/tv/" + mediaID
            case .season(let mediaID, let seasonNumber, _, _):
                return "/3/tv/" + mediaID + "/season/" + seasonNumber
            case .episode(let mediaID, let seasonNumber, let episodeNumber, _, _):
                return "/3/tv/" + mediaID + "/season/" + seasonNumber + "/episode/" + episodeNumber
            case .recommendations(let mediaID):
                return "/3/tv/" + mediaID + "/recommendations"
            case .aggregateCredits(let mediaID):
                return "/3/tv/" + mediaID + "/aggregate_credits"
            case .seasonAggregateCredits(let mediaID, let seasonNumber):
                return "/3/tv/" + mediaID + "/season/" + seasonNumber + "/aggregate_credits"
            case .episodeCredits(let mediaID, let seasonNumber, let episodeNumber):
                return "/3/tv/" + mediaID + "/season/" + seasonNumber + "/episode/" + episodeNumber + "/credits"
            case .credits(let mediaID):
                return "/3/tv/" + mediaID + "/credits"
            case .videos(let mediaID):
                return "/3/tv/" + mediaID + "/videos"
            case .seasonVideos(let mediaID, let seasonNumber):
                return "/3/tv/" + mediaID + "/season/" + seasonNumber + "/videos"
            case .episodeVideos(let mediaID, let seasonNumber, let episodeNumber):
                return "/3/tv/" + mediaID + "/season/" + seasonNumber + "/episode/" + episodeNumber + "/videos"
            }
            
        case .people(let endpoint):
            switch endpoint {
            case .details(let personID, _, _):
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
                
            case .details(_, let appendToResponse, let includeImageLanguage):
                let appendToResponseString = appendToResponse.map { $0.rawValue }.joined(separator: ",")
                let includeImageLanguageString = includeImageLanguage.map { $0.rawValue }.joined(separator: ",")
                return [
                    URLQueryItem(name: "append_to_response", value: appendToResponseString),
                    URLQueryItem(name: "include_image_language", value: includeImageLanguageString),
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
                
            case .videos:
                return [
                    URLQueryItem(name: "language", value: Language.en.rawValue),
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
                
            case .details(_, let appendToResponse, let includeImageLanguage):
                let appendToResponseString = appendToResponse.map { $0.rawValue }.joined(separator: ",")
                let includeImageLanguageString = includeImageLanguage.map { $0.rawValue }.joined(separator: ",")
                return [
                    URLQueryItem(name: "append_to_response", value: appendToResponseString),
                    URLQueryItem(name: "include_image_language", value: includeImageLanguageString),
                    URLQueryItem(name: "language", value: Language.ru.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey),
                ]
                
            case .season(_, _, let appendToResponse, let includeImageLanguage):
                let appendToResponseString = appendToResponse.map { $0.rawValue }.joined(separator: ",")
                let includeImageLanguageString = includeImageLanguage.map { $0.rawValue }.joined(separator: ",")
                return [
                    URLQueryItem(name: "append_to_response", value: appendToResponseString),
                    URLQueryItem(name: "include_image_language", value: includeImageLanguageString),
                    URLQueryItem(name: "language", value: Language.ru.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey),
                ]
                
            case .episode(_, _, _, let appendToResponse, let includeImageLanguage):
                let appendToResponseString = appendToResponse.map { $0.rawValue }.joined(separator: ",")
                let includeImageLanguageString = includeImageLanguage.map { $0.rawValue }.joined(separator: ",")
                return [
                    URLQueryItem(name: "append_to_response", value: appendToResponseString),
                    URLQueryItem(name: "include_image_language", value: includeImageLanguageString),
                    URLQueryItem(name: "language", value: Language.ru.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey),
                ]
                
            case .recommendations:
                return [
                    URLQueryItem(name: "language", value: Language.ru.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey),
                ]
                
            case .aggregateCredits:
                return [
                    URLQueryItem(name: "language", value: Language.ru.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey),
                ]
                
            case .seasonAggregateCredits:
                return [
                    URLQueryItem(name: "language", value: Language.ru.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey),
                ]
                
            case .episodeCredits:
                return [
                    URLQueryItem(name: "language", value: Language.ru.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey),
                ]
                
            case .credits:
                return [
                    URLQueryItem(name: "language", value: Language.ru.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey),
                ]
                
            case .videos:
                return [
                    URLQueryItem(name: "language", value: Language.en.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey),
                ]
                
            case .seasonVideos:
                return [
                    URLQueryItem(name: "language", value: Language.en.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey),
                ]
                
            case .episodeVideos:
                return [
                    URLQueryItem(name: "language", value: Language.en.rawValue),
                    URLQueryItem(name: "api_key", value: Self.apiKey),
                ]
            }
            
        case .people(let endpoint):
            switch endpoint {
            case .details(_, let appendToResponse, let includeImageLanguage):
                let appendToResponseString = appendToResponse.map { $0.rawValue }.joined(separator: ",")
                let includeImageLanguageString = includeImageLanguage.map { $0.rawValue }.joined(separator: ",")
                return [
                    URLQueryItem(name: "append_to_response", value: appendToResponseString),
                    URLQueryItem(name: "include_image_language", value: includeImageLanguageString),
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
        case details(mediaID: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage])
        case recommendations(mediaID: String)
        case credits(mediaID: String)
        case videos(mediaID: String)
    }
    
    enum TVEndpoint {
        
        case topRated(page: Int)
        case popular(page: Int)
        case onTheAir(page: Int)
        case airingToday(page: Int)
        
        case details(mediaID: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage])
        case season(mediaID: String, seasonNumber: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage])
        case episode(mediaID: String, seasonNumber: String, episodeNumber: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage])
        case recommendations(mediaID: String)
        
        case aggregateCredits(mediaID: String)
        case seasonAggregateCredits(mediaID: String, seasonNumber: String)
        case episodeCredits(mediaID: String, seasonNumber: String, episodeNumber: String)
        
        case credits(mediaID: String)
        
        case videos(mediaID: String)
        case seasonVideos(mediaID: String, seasonNumber: String)
        case episodeVideos(mediaID: String, seasonNumber: String, episodeNumber: String)
    }
    
    enum PeopleEndpoint {
        case details(personID: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage])
    }
    
    enum CreditEndpoint {
        case details(creditID: String)
    }
    
    enum AppendToResponse: String {
        case aggregateCredits = "aggregate_credits"
        case combinedCredits = "combined_credits"
        case credits
        case images
        case recommendations
        case similar
        case videos
    }
    
    enum IncludeImageLanguage: String {
        case ru
        case null
    }
    
    
    private enum Language: String {
        case ru = "ru-RU"
        case en = "en-US"
    }
    
}
