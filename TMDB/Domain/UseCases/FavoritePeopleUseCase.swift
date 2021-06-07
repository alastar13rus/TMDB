//
//  FavoritePeopleUseCase.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 04.06.2021.
//

import Foundation

public protocol FavoritePeopleUseCase {
    
    func readFavoritePeopleList(_ completion: @escaping ([PeopleModel]) -> Void)
    func saveFavoritePeople(_ completion: @escaping (Bool) -> Void)
    func removeFavoritePeople(_ peopleID: Int, _ completion: @escaping (Bool) -> Void)
    func toggleFavoriteStatus(_ model: PeopleModel, completion: @escaping (Bool) -> Void)
    func refreshFavoriteStatus(_ model: PeopleModel, completion: @escaping (Bool) -> Void)
    func isFavorite(_ model: PeopleModel, completion: @escaping (Bool) -> Void)
}
