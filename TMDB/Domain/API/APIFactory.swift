//
//  APIFactory.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation

public protocol APIFactory: AnyObject {
    func makeMovieListAPI() -> MovieListAPI
    func makeMovieDetailAPI() -> MovieDetailAPI
    func makeTVListAPI() -> TVListAPI
    func makeTVDetailAPI() -> TVDetailAPI
    func makeTVSeasonDetailAPI() -> TVSeasonDetailAPI
    func makeTVEpisodeDetailAPI() -> TVEpisodeDetailAPI
    func makePeopleDetailAPI() -> PeopleDetailAPI
    func makePeopleListAPI() -> PeopleListAPI
//    func makeCreditListAPI() -> CreditListAPI
    func makeSearchAPI() -> SearchAPI

}
