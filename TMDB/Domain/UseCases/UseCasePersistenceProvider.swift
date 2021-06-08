//
//  UseCasePersistenceProvider.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 04.06.2021.
//

import Foundation

public protocol UseCasePersistenceProvider {
    
    func makeFavoriteMovieUseCase() -> FavoriteMovieUseCase
    func makeFavoriteTVUseCase() -> FavoriteTVUseCase
    func makeFavoritePeopleUseCase() ->  FavoritePeopleUseCase
}
