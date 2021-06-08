//
//  UseCasePersistenceProviderMock.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 08.06.2021.
//

import Foundation
import Swinject
@testable import Domain
@testable import CoreDataPlatform

public final class UseCasePersistenceProviderMock: CoreDataPlatform.UseCasePersistenceProvider {
    
    public override func makeFavoriteMovieUseCase() -> Domain.FavoriteMovieUseCase {
        return FavoriteMovieUseCaseMock()
    }
    
    public override func makeFavoriteTVUseCase() -> Domain.FavoriteTVUseCase {
        return FavoriteTVUseCaseMock()
    }
    
    public override func makeFavoritePeopleUseCase() -> Domain.FavoritePeopleUseCase {
        return FavoritePeopleUseCaseMock()
    }
    


}
