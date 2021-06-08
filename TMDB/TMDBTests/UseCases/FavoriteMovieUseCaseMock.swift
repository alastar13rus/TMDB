//
//  FavoriteMovieUseCaseMock.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 08.06.2021.
//

import Foundation
@testable import Domain

class FavoriteMovieUseCaseMock: Domain.FavoriteMovieUseCase {
    
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
    
    func readFavoriteMovieList(_ completion: @escaping ([MovieModel]) -> Void) {
        
        switch storageState {
        case .empty: completion([])
        case .notEmpty:
            let movieModel = MovieModel(posterPath: nil, adult: false, overview: "overview", releaseDate: nil, genreIds: [], id: 123, originalTitle: "originalTitle", originalLanguage: "originalLanguage", title: "movieModel", backdropPath: nil, popularity: 0, voteCount: 1, video: false, voteAverage: 1)
            let movieModel2 = MovieModel(posterPath: nil, adult: false, overview: "overview 2", releaseDate: nil, genreIds: [], id: 456, originalTitle: "originalTitle 2", originalLanguage: "originalLanguage 2", title: "movieModel 2", backdropPath: nil, popularity: 0, voteCount: 1, video: false, voteAverage: 1)
            completion([movieModel, movieModel2])
        }
        
        
    }
    
    func toggleFavoriteStatus(_ model: MovieModel, completion: @escaping (Bool) -> Void) {
        completion(!isFavoriteState)
    }
    
    func isFavorite(_ model: MovieModel, completion: @escaping (Bool) -> Void) {
        completion(isFavoriteState)
    }
    
    
    func saveFavoriteMovie(_ completion: @escaping (Bool) -> Void) {
        storageState = .notEmpty
        countOfFavoriteMedia += 1
        completion(true)
    }
    
    func removeFavoriteMovie(_ modelID: Int, _ completion: @escaping (Bool) -> Void) {
        countOfFavoriteMedia -= 1
        if countOfFavoriteMedia == 0 { storageState = .empty }
        completion(true)
    }
}
