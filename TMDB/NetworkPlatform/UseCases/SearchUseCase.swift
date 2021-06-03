//
//  SearchUseCase.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import Foundation
import Domain

final class SearchUseCase: Domain.SearchUseCase {
    
    private let network: SearchNetwork
    private let api: SearchAPI

    init(_ network: SearchNetwork, _ api: SearchAPI) {
        self.network = network
        self.api = api
    }
    
    func searchQuickCategories(_ completion: @escaping ([SearchCategory]) -> Void) {
        
        let categories: [SearchCategory] = [
            .movieListByGenres(title: "Фильмы (по жанрам)"),
            .movieListByYears(title: "Фильмы (по годам)"),
            .tvListByGenres(title: "Сериалы (по жанрам)"),
            .tvListByYears(title: "Сериалы (по годам)"),
        ]
        completion(categories)
    }
    
    func showMediaByYearFilterOptions(mediaType: MediaType, completion: @escaping ([FilterOptionMediaByYearModel]) -> Void) {
        
        let currentYear = Calendar.current.component(.year, from: Date())
        
        let options = (currentYear - 9 ... currentYear).reduce([FilterOptionMediaByYearModel]()) { (accumulator, year) in
            var options = accumulator
            options.append(FilterOptionMediaByYearModel(year: year, mediaType: mediaType))
            return options
        }
        
        completion(options.reversed())
    }
    
    func showMediaByGenreFilterOptions(mediaType: MediaType, completion: @escaping (Result<GenreModelResponse, Error>) -> Void) {
        
        let request = api.mediaGenreList(mediaType: mediaType)
        network.fetchFilterOptionListMediaByGenre(request, completion: completion)
    }
    
    func filterMediaListByYear<T: MediaProtocol>(_ year: String, mediaType: MediaType, page: Int, completion: @escaping (Result<MediaListResponse<T>, Error>) -> Void) {
        
        let request = api.mediaListByYear(year, mediaType: mediaType, page: page)
        network.fetchMediaListByYear(request, completion: completion)
    }
    
    func filterMediaListByGenre<T: MediaProtocol>(_ genreID: String, mediaType: MediaType, page: Int, completion: @escaping (Result<MediaListResponse<T>, Error>) -> Void) {
        
        let request = api.mediaListByGenre(genreID, mediaType: mediaType, page: page)
        network.fetchMediaListByGenre(request, completion: completion)
    }
    
    func multiSearch(_ query: String, page: Int, completion: @escaping (Result<MultiSearchResponse, Error>) -> Void) {
        
        let request = api.multiSearch(query, page: page)
        network.multiSearch(request, completion: completion)
    }
    
}
