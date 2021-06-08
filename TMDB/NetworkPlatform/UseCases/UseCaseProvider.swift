//
//  UseCaseProvider.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Swinject
import Domain

open class UseCaseProvider: Domain.UseCaseProvider {
    
    let networkProvider: NetworkProvider
    public let apiFactory: Domain.APIFactory
    
    public init(networkProvider: NetworkProvider, apiFactory: Domain.APIFactory) {
        self.networkProvider = networkProvider
        self.apiFactory = apiFactory
    }
    
    public func makeMovieListUseCase() -> Domain.MovieListUseCase {
        
        return MovieListUseCase(networkProvider.makeMovieListRepository(), apiFactory.makeMovieListAPI() as! MovieListAPI)
    }
    
    public func makeTVListUseCase() -> Domain.TVListUseCase {
        return TVListUseCase(networkProvider.makeTVListRepository(), apiFactory.makeTVListAPI() as! TVListAPI)
    }
    
    public func makeMovieDetailUseCase() -> Domain.MovieDetailUseCase {
        return MovieDetailUseCase(networkProvider.makeMovieDetailRepository(), apiFactory.makeMovieDetailAPI() as! MovieDetailAPI)
    }
    
    public func makeTVDetailUseCase() ->  Domain.TVDetailUseCase {
        return TVDetailUseCase(networkProvider.makeTVDetailRepository(), apiFactory.makeTVDetailAPI() as! TVDetailAPI)
    }
    
    public func makeTVSeasonDetailUseCase() ->  Domain.TVSeasonDetailUseCase {
        return TVSeasonDetailUseCase(networkProvider.makeTVSeasonDetailRepository(), apiFactory.makeTVSeasonDetailAPI() as! TVSeasonDetailAPI)
    }
    
    public func makeTVEpisodeDetailUseCase() ->  Domain.TVEpisodeDetailUseCase {
        return TVEpisodeDetailUseCase(networkProvider.makeTVEpisodeDetailRepository(), apiFactory.makeTVEpisodeDetailAPI() as! TVEpisodeDetailAPI)
    }
    
    public func makePeopleDetailUseCase() ->  Domain.PeopleDetailUseCase {
        return PeopleDetailUseCase(networkProvider.makePeopleDetailRepository(), apiFactory.makePeopleDetailAPI() as! PeopleDetailAPI)
    }
    
//    public func makeCreditListUseCase() ->  Domain.CreditListUseCase {
//        return CreditListUseCase(network: CreditListRepository)
//    }
    
    public func makePeopleListUseCase() ->  Domain.PeopleListUseCase {
        return PeopleListUseCase(networkProvider.makePeopleListRepository(), apiFactory.makePeopleListAPI() as! PeopleListAPI)
    }
    
    public func makeSearchUseCase() ->  Domain.SearchUseCase {
        return SearchUseCase(networkProvider.makeSearchRepository(), apiFactory.makeSearchAPI() as! SearchAPI)
    }
    
}
