//
//  CoreDataProvider.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 03.06.2021.
//

import Foundation
import Domain

public final class CoreDataProvider {
    
    let coreData: CoreDataAgent
    
    public init(coreData: CoreDataAgent) {
        self.coreData = coreData
    }
    
    func makeFavoriteMovieRepository() -> FavoriteMovieRepository {
        let favoriteMovieRepository = FavoriteMovieRepository(coreData)
        return favoriteMovieRepository
    }
    
    func makeFavoriteTVRepository() -> FavoriteTVRepository {
        let favoriteTVRepository = FavoriteTVRepository(coreData)
        return favoriteTVRepository
    }
    
    func makeFavoritePeopleRepository() -> FavoritePeopleRepository {
        let favoritePeopleRepository = FavoritePeopleRepository(coreData)
        return favoritePeopleRepository
    }
    
}
