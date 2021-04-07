//
//  MovieListResponse.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 15.03.2021.
//

import Foundation

struct MediaListResponse<T: MediaProtocol>: MediaListResponseProtocol {

    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [T]

}

extension MediaListResponse {
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
