//
//  FavoriteMovieUseCase.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 04.06.2021.
//

import Foundation

public protocol FavoriteMovieUseCase {
    
    func readFavoriteMovieList(_ completion: @escaping ([MovieModel]) -> Void)
    func saveFavoriteMovie(_ completion: @escaping (Bool) -> Void)
    func removeFavoriteMovie(_ completion: @escaping (Bool) -> Void)
    func toggleFavoriteStatus(_ model: MovieModel, completion: @escaping (Bool) -> Void)
    func isFavorite(_ model: MovieModel, completion: @escaping (Bool) -> Void)
}
