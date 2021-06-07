//
//  FavoritePeopleUseCase.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 04.06.2021.
//

import Foundation
import Domain

class FavoritePeopleUseCase: Domain.FavoritePeopleUseCase {
    
    private let repository: FavoritePeopleRepository

    init(_ repository: FavoritePeopleRepository) {
        self.repository = repository
    }
    
    func readFavoritePeopleList(_ completion: @escaping ([PeopleModel]) -> Void) {
        repository.readFavoritePeopleList { completion($0) }
    }
    
    func toggleFavoriteStatus(_ model: PeopleModel, completion: @escaping (Bool) -> Void) {
        repository.toggleFavorite(model) { completion($0) }
    }
    
    func refreshFavoriteStatus(_ model: PeopleModel, completion: @escaping (Bool) -> Void) {
        repository.refreshFavorite(model) { completion($0) }
    }
    
    func isFavorite(_ model: PeopleModel, completion: @escaping (Bool) -> Void) {
        repository.isFavorite(model) { completion($0) }
    }
    
    
    func saveFavoritePeople(_ completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    func removeFavoritePeople(_ modelID: Int, _ completion: @escaping (Bool) -> Void) {
        repository.deleteFavoritePeople(modelID) { completion($0) }
    }
}
