//
//  UseCaseProviderMock.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 07.06.2021.
//

import Foundation
import Swinject
@testable import Domain
@testable import NetworkPlatform

public final class UseCaseProviderMock: NetworkPlatform.UseCaseProvider {
    
    public override func makeMovieDetailUseCase() -> Domain.MovieDetailUseCase {
        return MovieDetailUseCaseMock()
    }
    
    public override func makeTVDetailUseCase() -> Domain.TVDetailUseCase {
        return TVDetailUseCaseMock()
    }


}
