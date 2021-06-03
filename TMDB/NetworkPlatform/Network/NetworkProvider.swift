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
    
    func makeMovieListNetwork() -> MovieListNetwork {
        let movieListNetwork = MovieListNetwork(network)
        return movieListNetwork
    }
    
    func makeMovieDetailNetwork() -> MovieDetailNetwork {
        let movieDetailNetwork = MovieDetailNetwork(network)
        return movieDetailNetwork
    }
    
    func makeTVListNetwork() -> TVListNetwork {
        let tvListNetwork = TVListNetwork(network)
        return tvListNetwork
    }
    
    func makeTVDetailNetwork() -> TVDetailNetwork {
        let tvDetailNetwork = TVDetailNetwork(network)
        return tvDetailNetwork
    }
    
    func makeTVSeasonDetailNetwork() -> TVSeasonDetailNetwork {
        let tvSeasonDetailNetwork = TVSeasonDetailNetwork(network)
        return tvSeasonDetailNetwork
    }
    
    func makeTVEpisodeDetailNetwork() -> TVEpisodeDetailNetwork {
        let tvEpisodeDetailNetwork = TVEpisodeDetailNetwork(network)
        return tvEpisodeDetailNetwork
    }
    
    func makePeopleDetailNetwork() -> PeopleDetailNetwork {
        let peopleDetailNetwork = PeopleDetailNetwork(network)
        return peopleDetailNetwork
    }
    
    func makePeopleListNetwork() -> PeopleListNetwork {
        let peopleListNetwork = PeopleListNetwork(network)
        return peopleListNetwork
    }
    
    func makeSearchNetwork() -> SearchNetwork {
        let searchNetwork = SearchNetwork(network)
        return searchNetwork
    }
    
}
