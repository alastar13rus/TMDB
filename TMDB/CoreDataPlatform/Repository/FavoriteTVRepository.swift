//
//  FavoriteTVRepository.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 04.06.2021.
//

import Foundation
import Domain

final class FavoriteTVRepository {
    
    let coreData: CoreDataAgent
    
    init(_ coreData: CoreDataAgent) {
        self.coreData = coreData
    }
    
    public func readFavoriteTVList(_ completion: @escaping ([TVModel]) -> Void) {
        completion(coreData.fetchAll(entityType: TVModel.self))
    }
    
    public func isFavorite(_ model: TVModel, _ completion: @escaping (Bool) -> Void) {
        let tvModel = coreData.fetch(entityID: model.id, type: TVModel.self)
        completion(tvModel != nil)
    }
    
    public func toggleFavorite(_ model: TVModel, _ completion: @escaping (Bool) -> Void) {
        isFavorite(model) { [weak self] (isFavorite) in
            isFavorite ?
                self?.deleteFavoriteTV(model.id) { completion($0 ? false: true) } :
                self?.createFavoriteTV(model) { completion($0 ? true: false) }
        }
    }
    
    public func refreshFavorite(_ model: TVModel, _ completion: @escaping (Bool) -> Void) {
        isFavorite(model) { completion($0) }
    }
    
    public func deleteFavoriteTV(_ modelID: Int, _ completion: @escaping (Bool) -> Void) {
        coreData.delete(entityID: modelID, type: TVModel.self)
        completion(true)
    }
    
    private func createFavoriteTV(_ model: TVModel, _ completion: @escaping (Bool) -> Void) {
        coreData.save(entity: model)
        completion(true)
    }
    
}
