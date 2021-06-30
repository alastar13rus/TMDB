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
        return MovieListUseCase(networkProvider.makeMovieListRepository(), apiFactory.makeMovieListAPI())
    }
    
    public func makeTVListUseCase() -> Domain.TVListUseCase {
        return TVListUseCase(networkProvider.makeTVListRepository(), apiFactory.makeTVListAPI())
    }
    
    public func makeMovieDetailUseCase() -> Domain.MovieDetailUseCase {
        return MovieDetailUseCase(networkProvider.makeMovieDetailRepository(), apiFactory.makeMovieDetailAPI())
    }
    
    public func makeTVDetailUseCase() ->  Domain.TVDetailUseCase {
        return TVDetailUseCase(networkProvider.makeTVDetailRepository(), apiFactory.makeTVDetailAPI())
    }
    
    public func makeTVSeasonDetailUseCase() ->  Domain.TVSeasonDetailUseCase {
        return TVSeasonDetailUseCase(networkProvider.makeTVSeasonDetailRepository(), apiFactory.makeTVSeasonDetailAPI())
    }
    
    public func makeTVEpisodeDetailUseCase() ->  Domain.TVEpisodeDetailUseCase {
        return TVEpisodeDetailUseCase(networkProvider.makeTVEpisodeDetailRepository(), apiFactory.makeTVEpisodeDetailAPI())
    }
    
    public func makePeopleDetailUseCase() ->  Domain.PeopleDetailUseCase {
        return PeopleDetailUseCase(networkProvider.makePeopleDetailRepository(), apiFactory.makePeopleDetailAPI())
    }
    
//    public func makeCreditListUseCase() ->  Domain.CreditListUseCase {
//        return CreditListUseCase(network: CreditListRepository)
//    }
    
    public func makePeopleListUseCase() ->  Domain.PeopleListUseCase {
        return PeopleListUseCase(networkProvider.makePeopleListRepository(), apiFactory.makePeopleListAPI())
    }
    
    public func makeSearchUseCase() ->  Domain.SearchUseCase {
        return SearchUseCase(networkProvider.makeSearchRepository(), apiFactory.makeSearchAPI())
    }
    public func makeMonitoringUseCase() ->  Domain.MonitoringUseCase {
        return MonitoringUseCase()
    }
    
}
