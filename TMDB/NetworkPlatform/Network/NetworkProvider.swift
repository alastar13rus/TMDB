//
//  NetworkProvider.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

public final class NetworkProvider {
    
    let network: NetworkAgent
    
    public init(network: NetworkAgent) {
        self.network = network
    }
    
    func makeMovieListRepository() -> MovieListRepository {
        let movieListRepository = MovieListRepository(network)
        return movieListRepository
    }
    
    func makeMovieDetailRepository() -> MovieDetailRepository {
        let movieDetailRepository = MovieDetailRepository(network)
        return movieDetailRepository
    }
    
    func makeTVListRepository() -> TVListRepository {
        let tvListRepository = TVListRepository(network)
        return tvListRepository
    }
    
    func makeTVDetailRepository() -> TVDetailRepository {
        let tvDetailRepository = TVDetailRepository(network)
        return tvDetailRepository
    }
    
    func makeTVSeasonDetailRepository() -> TVSeasonDetailRepository {
        let tvSeasonDetailRepository = TVSeasonDetailRepository(network)
        return tvSeasonDetailRepository
    }
    
    func makeTVEpisodeDetailRepository() -> TVEpisodeDetailRepository {
        let tvEpisodeDetailRepository = TVEpisodeDetailRepository(network)
        return tvEpisodeDetailRepository
    }
    
    func makePeopleDetailRepository() -> PeopleDetailRepository {
        let peopleDetailRepository = PeopleDetailRepository(network)
        return peopleDetailRepository
    }
    
    func makePeopleListRepository() -> PeopleListRepository {
        let peopleListRepository = PeopleListRepository(network)
        return peopleListRepository
    }
    
    func makeSearchRepository() -> SearchRepository {
        let searchRepository = SearchRepository(network)
        return searchRepository
    }
    
}
