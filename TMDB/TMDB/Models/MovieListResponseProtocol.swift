//
//  MovieListResponseProtocol.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 15.03.2021.
//

import Foundation

protocol MovieListResponseProtocol {
    var page: Int { get }
    var totalResults: Int { get }
    var totalPages: Int { get }
    var results: [MovieProtocol] { get }
}
