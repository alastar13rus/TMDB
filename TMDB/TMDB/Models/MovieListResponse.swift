//
//  MovieListResponse.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 15.03.2021.
//

import Foundation

struct MovieListResponse: MovieListResponseProtocol {
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [MovieProtocol]
    
    
}
