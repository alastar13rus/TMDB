//
//  UseCasePersistenceProvider.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 03.06.2021.
//

import Foundation
import Domain

public final class UseCasePersistenceProvider: Domain.UseCasePersistenceProvider {
    
    private let dbProvider: CoreDataProvider
    
    public init(dbProvider: CoreDataProvider) {
        self.dbProvider = dbProvider
    }
    
    public func makeFavoriteMovieUseCase() -> Domain.FavoriteMovieUseCase {
        return FavoriteMovieUseCase(dbProvider.makeFavoriteMovieRepository())
    }
    
    public func makeFavoriteTVUseCase() -> Domain.FavoriteTVUseCase {
        return FavoriteTVUseCase(dbProvider.makeFavoriteTVRepository())
    }
    
    public func makeFavoritePeopleUseCase() -> Domain.FavoritePeopleUseCase {
        return FavoritePeopleUseCase(dbProvider.makeFavoritePeopleRepository())
    }
}
