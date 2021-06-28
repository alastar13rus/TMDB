//
//  FavoriteTVUseCase.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 04.06.2021.
//

import Foundation

public protocol FavoriteTVUseCase {
    
    func readFavoriteTVList(_ completion: @escaping ([TVModel]) -> Void)
    func saveFavoriteTV(_ completion: @escaping (Bool) -> Void)
    func removeFavoriteTV(_ modelID: Int, _ completion: @escaping (Bool) -> Void)
    func toggleFavoriteStatus(_ model: TVModel, completion: @escaping (Bool) -> Void)
    func isFavorite(_ model: TVModel, completion: @escaping (Bool) -> Void)
    
}
