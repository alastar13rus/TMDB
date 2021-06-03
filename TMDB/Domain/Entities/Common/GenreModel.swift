//
//  GenreModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 08.04.2021.
//

import Foundation

public struct GenreModel: Decodable {
    public let id: Int
    public let name: String
}

public struct GenreModelResponse: Decodable {
    public let genres: [GenreModel]
}
