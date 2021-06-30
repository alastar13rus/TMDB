//
//  SearchUseCase.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import Foundation

public protocol SearchUseCase: UseCase {
    
    func searchQuickCategories(_ completion: @escaping ([SearchCategory]) -> Void)
    func showMediaByYearFilterOptions(mediaType: MediaType,
                                      completion: @escaping ([FilterOptionMediaByYearModel]) -> Void)
    
    func showMediaByGenreFilterOptions(mediaType: MediaType,
                                       completion: @escaping (Result<GenreModelResponse, Error>) -> Void)
    
    func filterMediaListByYear<T: MediaProtocol>(_ year: String,
                                                 mediaType: MediaType,
                                                 page: Int,
                                                 completion: @escaping (Result<MediaListResponse<T>, Error>) -> Void)
    
    func filterMediaListByGenre<T: MediaProtocol>(_ year: String,
                                                  mediaType: MediaType,
                                                  page: Int,
                                                  completion: @escaping (Result<MediaListResponse<T>, Error>) -> Void)
    
    func multiSearch(_ query: String,
                     page: Int,
                     completion: @escaping (Result<MultiSearchResponse, Error>) -> Void)
}
