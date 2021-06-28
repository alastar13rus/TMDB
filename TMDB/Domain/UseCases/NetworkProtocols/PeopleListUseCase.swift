//
//  PeopleListUseCase.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import Foundation

public protocol PeopleListUseCase: UseCase {
    func popular(_ completion: @escaping (Result<PeopleListResponse, Error>) -> Void)
}
