//
//  SearchListUseCase.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import Foundation

public protocol SearchListUseCase: UseCase {
    func searchQuickCategories(_ completion: @escaping (Result<[SearchCategory], Error>) -> Void)
}
