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
        let movieModel = coreData.fetch(entity: model)
        completion(movieModel != nil)
    }
    
    public func toggleFavorite(_ model: PeopleModel, _ completion: @escaping (Bool) -> Void) {
        isFavorite(model) { [weak self] (isFavorite) in
            isFavorite ?
                self?.deleteFavoritePeople(model) { completion($0 ? false: true) } :
                self?.createFavoritePeople(model) { completion($0 ? true: false) }
        }
    }
    
    private func deleteFavoritePeople(_ model: PeopleModel, _ completion: @escaping (Bool) -> Void) {
        coreData.delete(entity: model)
        completion(true)
    }
    
    private func createFavoritePeople(_ model: PeopleModel, _ completion: @escaping (Bool) -> Void) {
        coreData.save(entity: model)
        completion(true)
    }
    
}

