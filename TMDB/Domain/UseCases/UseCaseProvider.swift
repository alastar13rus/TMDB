//
//  UseCaseProvider.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 16.05.2021.
//

import Foundation

public protocol UseCase { }

public protocol UseCaseProvider {
    
    var apiFactory: APIFactory { get }
    
    func makeMovieListUseCase() -> MovieListUseCase
    func makeTVListUseCase() -> TVListUseCase
    func makeMovieDetailUseCase() -> MovieDetailUseCase
    func makeTVDetailUseCase() ->  TVDetailUseCase
    func makeTVSeasonDetailUseCase() -> TVSeasonDetailUseCase
    func makeTVEpisodeDetailUseCase() -> TVEpisodeDetailUseCase
//    func makeCreditListUseCase() ->  CreditListUseCase
    func makePeopleDetailUseCase() ->  PeopleDetailUseCase

}
