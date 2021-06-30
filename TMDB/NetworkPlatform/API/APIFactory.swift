//
//  APIFactory.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

public class APIFactory: Domain.APIFactory {
    
    let config: (apiKey: String, apiBaseURL: String)
    
    public init(_ config: (apiKey: String, apiBaseURL: String)) {
        self.config = config
    }
    
// MARK: - MovieFlow
    public func makeMovieListAPI() -> Domain.MovieListAPI {
        return MovieListAPI(config)
    }
    
    public func makeMovieDetailAPI() -> Domain.MovieDetailAPI {
        return MovieDetailAPI(config)
    }
    
// MARK: - TVFlow
    public func makeTVListAPI() -> Domain.TVListAPI {
        return TVListAPI(config)
    }
    
    public func makeTVDetailAPI() -> Domain.TVDetailAPI {
        return TVDetailAPI(config)
    }

// MARK: - TVSeasonFlow
    public func makeTVSeasonDetailAPI() -> Domain.TVSeasonDetailAPI {
        return TVSeasonDetailAPI(config)
    }
    
// MARK: - TVEpisodeFlow
    public func makeTVEpisodeDetailAPI() -> Domain.TVEpisodeDetailAPI {
        return TVEpisodeDetailAPI(config)
    }
    
// MARK: - TVPeopleFlow
    public func makePeopleDetailAPI() -> Domain.PeopleDetailAPI {
        return PeopleDetailAPI(config)
    }
    
    public func makePeopleListAPI() -> Domain.PeopleListAPI {
        return PeopleListAPI(config)
    }
    
// MARK: - TVPeopleFlow
    public func makeSearchAPI() -> Domain.SearchAPI {
        return SearchAPI(config)
    }
    
}
