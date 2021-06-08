//
//  FavoriteMovieRepository.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 04.06.2021.
//

import Foundation
import Domain

final class FavoriteMovieRepository {
    
    let coreData: CoreDataAgent
    
    init(_ coreData: CoreDataAgent) {
        self.coreData = coreData
    }
    
    public func readFavoriteMovieList(_ completion: @escaping ([MovieModel]) -> Void) {
        completion(coreData.fetchAll(entityType: MovieModel.self))
    }
    
    public func isFavorite(_ model: MovieModel, _ completion: @escaping (Bool) -> Void) {
        let movieModel = coreData.fetch(entityID: model.id, type: MovieModel.self)
        completion(movieModel != nil)
    }
    
    public func toggleFavorite(_ model: MovieModel, _ completion: @escaping (Bool) -> Void) {
        isFavorite(model) { [weak self] (isFavorite) in
            isFavorite ?
                self?.deleteFavoriteMovie(model.id) { completion($0 ? false: true) } :
                self?.createFavoriteMovie(model) { completion($0 ? true: false) }
        }
    }
    
    public func deleteFavoriteMovie(_ modelID: Int, _ completion: @escaping (Bool) -> Void) {
        coreData.delete(entityID: modelID, type: MovieModel.self)
        completion(true)
    }
    
    private func createFavoriteMovie(_ model: MovieModel, _ completion: @escaping (Bool) -> Void) {
        coreData.save(entity: model)
        completion(true)
    }
    
}
