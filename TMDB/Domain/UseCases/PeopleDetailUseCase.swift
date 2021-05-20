//
//  PeopleDetailUseCase.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation

public protocol PeopleDetailUseCase: UseCase {
    func details(personID: String,
                 appendToResponse: [AppendToResponse],
                 includeImageLanguage: [IncludeImageLanguage],
                 completion: @escaping (Result<PeopleDetailModel, Error>) -> Void)
}
