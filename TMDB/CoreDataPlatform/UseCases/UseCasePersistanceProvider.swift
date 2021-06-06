//
//  UseCasePersistenceProvider.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 03.06.2021.
//

import Foundation
import Domain

public final class UseCasePersistenceProvider: Domain.UseCasePersistenceProvider {
    private let coreDataStack = CoreDataStack()
    private let postRepository: Repository<Post>
    
    public init() {
        postRepository = Repository<Post>(context: coreDataStack.context)
    }

    public func makePostsUseCase() -> Domain.PostsUseCase {
        return PostsUseCase(repository: postRepository)
    }
}
