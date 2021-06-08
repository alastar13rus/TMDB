//
//  FavoritePeopleUseCaseMock.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 08.06.2021.
//

import Foundation
@testable import Domain

class FavoritePeopleUseCaseMock: Domain.FavoritePeopleUseCase {
    
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
    
    func readFavoritePeopleList(_ completion: @escaping ([PeopleModel]) -> Void) {
        
        switch storageState {
        case .empty: completion([])
        case .notEmpty:
            let peopleModel = PeopleModel(adult: true, id: 123, knownFor: [], name: "people", popularity: 1, profilePath: nil)
            let peopleModel2 = PeopleModel(adult: false, id: 456, knownFor: [], name: "people 2", popularity: 2, profilePath: nil)
            completion([peopleModel, peopleModel2])
        }
        
        
    }
    
    func toggleFavoriteStatus(_ model: PeopleModel, completion: @escaping (Bool) -> Void) {
        completion(!isFavoriteState)
    }
    
    func isFavorite(_ model: PeopleModel, completion: @escaping (Bool) -> Void) {
        completion(isFavoriteState)
    }
    
    
    func saveFavoritePeople(_ completion: @escaping (Bool) -> Void) {
        storageState = .notEmpty
        countOfFavoriteMedia += 1
        completion(true)
    }
    
    func removeFavoritePeople(_ modelID: Int, _ completion: @escaping (Bool) -> Void) {
        countOfFavoriteMedia -= 1
        if countOfFavoriteMedia == 0 { storageState = .empty }
        completion(true)
    }
}
