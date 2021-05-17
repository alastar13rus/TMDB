//
//  MovieDetailUseCase.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 16.05.2021.
//

import Foundation

protocol MovieDetailUseCase {
    func fetchMovieDetail<T: MovieProtocol>(completion: @escaping (T) -> Void)
}
