//
//  FavoriteMovieUseCase.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 04.06.2021.
//

import Foundation
import Domain

class FavoriteMovieUseCase: Domain.FavoriteMovieUseCase {

    private let repository: FavoriteMovieRepository

    init(_ repository: FavoriteMovieRepository) {
        self.repository = repository
    }
    
    func readFavoriteMovieList(_ completion: @escaping ([MovieModel]) -> Void) {
        repository.readFavoriteMovieList { completion($0) }
    }
    
    func toggleFavoriteStatus(_ model: MovieModel, completion: @escaping (Bool) -> Void) {
        repository.toggleFavorite(model) { completion($0) }
    }
    
    func isFavorite(_ model: MovieModel, completion: @escaping (Bool) -> Void) {
        repository.isFavorite(model) { completion($0) }
    }
    
    
    func saveFavoriteMovie(_ completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    func removeFavoriteMovie(_ modelID: Int, _ completion: @escaping (Bool) -> Void) {
        repository.deleteFavoriteMovie(modelID) { completion($0) }
    }
}
