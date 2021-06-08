//
//  FavoriteTVUseCaseMock.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 08.06.2021.
//

import Foundation
@testable import Domain

class FavoriteTVUseCaseMock: Domain.FavoriteTVUseCase {
    
    let isFavoriteState: Bool = false
    var storageState: StorageState = .empty {
        didSet {
            if case .empty = storageState { countOfFavoriteMedia = 0 }
            if case .notEmpty = storageState { countOfFavoriteMedia = 2 }

        }
    }
    var countOfFavoriteMedia = 0
    
    enum StorageState {
        case empty
        case notEmpty
    }
    
    func readFavoriteTVList(_ completion: @escaping ([TVModel]) -> Void) {
        
        switch storageState {
        case .empty: completion([])
        case .notEmpty:
            let tvModel = TVModel(firstAirDate: nil, originCountry: [], name: "tvModel", originalName: "originalName", id: 123, popularity: 1, voteCount: 2, posterPath: nil, backdropPath: nil, originalLanguage: "", genreIds: [], voteAverage: 3, overview: "overview")
            let tvModel2 = TVModel(firstAirDate: nil, originCountry: [], name: "tvModel 2", originalName: "originalName", id: 456, popularity: 4, voteCount: 5, posterPath: nil, backdropPath: nil, originalLanguage: "", genreIds: [], voteAverage: 6, overview: "overview 2")
            completion([tvModel, tvModel2])
        }
        
        
    }
    
    func toggleFavoriteStatus(_ model: TVModel, completion: @escaping (Bool) -> Void) {
        completion(!isFavoriteState)
    }
    
    func isFavorite(_ model: TVModel, completion: @escaping (Bool) -> Void) {
        completion(isFavoriteState)
    }
    
    
    func saveFavoriteTV(_ completion: @escaping (Bool) -> Void) {
        storageState = .notEmpty
        countOfFavoriteMedia += 1
        completion(true)
    }
    
    func removeFavoriteTV(_ modelID: Int, _ completion: @escaping (Bool) -> Void) {
        countOfFavoriteMedia -= 1
        if countOfFavoriteMedia == 0 { storageState = .empty }
        completion(true)
    }
}
