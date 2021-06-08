//
//  FavoriteTVUseCase.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 04.06.2021.
//

import Foundation
import Domain

class FavoriteTVUseCase: Domain.FavoriteTVUseCase {

    private let repository: FavoriteTVRepository

    init(_ repository: FavoriteTVRepository) {
        self.repository = repository
    }
    
    public func readFavoriteTVList(_ completion: @escaping ([TVModel]) -> Void) {
        repository.readFavoriteTVList { completion($0) }
    }
    
    func toggleFavoriteStatus(_ model: TVModel, completion: @escaping (Bool) -> Void) {
        repository.toggleFavorite(model) { completion($0) }
    }
    
    func isFavorite(_ model: TVModel, completion: @escaping (Bool) -> Void) {
        repository.isFavorite(model) { completion($0) }
    }
    
    public func saveFavoriteTV(_ completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    public func removeFavoriteTV(_ modelID: Int, _ completion: @escaping (Bool) -> Void) {
        repository.deleteFavoriteTV(modelID) { completion($0) }
    }
}
