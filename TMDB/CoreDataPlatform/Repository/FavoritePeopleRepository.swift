//
//  FavoritePeopleRepository.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 04.06.2021.
//

import Foundation
import Domain

final class FavoritePeopleRepository {
    
    let coreData: CoreDataAgent
    
    init(_ coreData: CoreDataAgent) {
        self.coreData = coreData
    }
    
    public func readFavoritePeopleList(_ completion: @escaping ([PeopleModel]) -> Void) {
        completion(coreData.fetchAll(entityType: PeopleModel.self))
    }
    
    public func isFavorite(_ model: PeopleModel, _ completion: @escaping (Bool) -> Void) {
        let movieModel = coreData.fetch(entityID: model.uid, type: PeopleModel.self)
        completion(movieModel != nil)
    }
    
    public func toggleFavorite(_ model: PeopleModel, _ completion: @escaping (Bool) -> Void) {
        isFavorite(model) { [weak self] (isFavorite) in
            isFavorite ?
                self?.deleteFavoritePeople(model.uid) { completion($0 ? false: true) } :
                self?.createFavoritePeople(model) { completion($0 ? true: false) }
        }
    }
    
    public func refreshFavorite(_ model: PeopleModel, _ completion: @escaping (Bool) -> Void) {
        isFavorite(model) { completion($0) }
    }
    
    public func deleteFavoritePeople(_ modelID: Int, _ completion: @escaping (Bool) -> Void) {
        coreData.delete(entityID: modelID, type: PeopleModel.self)
        completion(true)
    }
    
    private func createFavoritePeople(_ model: PeopleModel, _ completion: @escaping (Bool) -> Void) {
        coreData.save(entity: model)
        completion(true)
    }
    
}
