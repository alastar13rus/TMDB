//
//  UseCaseProvider.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Swinject
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    
    let networkProvider: NetworkProvider
    public let apiFactory: Domain.APIFactory
    
    public init(networkProvider: NetworkProvider, apiFactory: Domain.APIFactory) {
        self.networkProvider = networkProvider
        self.apiFactory = apiFactory
    }
    
    public func makeMovieListUseCase() -> Domain.MovieListUseCase {
        
        return MovieListUseCase(networkProvider.makeMovieListNetwork(),
                                apiFactory.makeMovieListAPI() as! MovieListAPI)
    }
    
    public func makeTVListUseCase() -> Domain.TVListUseCase {
        return TVListUseCase(networkProvider.makeTVListNetwork(), apiFactory.makeTVListAPI() as! TVListAPI)
    }
    
    public func makeMovieDetailUseCase() -> Domain.MovieDetailUseCase {
        return MovieDetailUseCase(networkProvider.makeMovieDetailNetwork(), apiFactory.makeMovieDetailAPI() as! MovieDetailAPI)
    }
    
    public func makeTVDetailUseCase() ->  Domain.TVDetailUseCase {
        return TVDetailUseCase(networkProvider.makeTVDetailNetwork(), apiFactory.makeTVDetailAPI() as! TVDetailAPI)
    }
    
    public func makeTVSeasonDetailUseCase() ->  Domain.TVSeasonDetailUseCase {
        return TVSeasonDetailUseCase(networkProvider.makeTVSeasonDetailNetwork(), apiFactory.makeTVSeasonDetailAPI() as! TVSeasonDetailAPI)
    }
    
    public func makeTVEpisodeDetailUseCase() ->  Domain.TVEpisodeDetailUseCase {
        return TVEpisodeDetailUseCase(networkProvider.makeTVEpisodeDetailNetwork(), apiFactory.makeTVEpisodeDetailAPI() as! TVEpisodeDetailAPI)
    }
    
    public func makePeopleDetailUseCase() ->  Domain.PeopleDetailUseCase {
        return PeopleDetailUseCase(networkProvider.makePeopleDetailNetwork(), apiFactory.makePeopleDetailAPI() as! PeopleDetailAPI)
    }
    
//    public func makeCreditListUseCase() ->  Domain.CreditListUseCase {
//        return CreditListUseCase(network: <#T##CreditListNetwork#>)
//    }
    
}
