//
//  MovieListResponse.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 15.03.2021.
//

import Foundation

public struct MediaListResponse<T: MediaProtocol>: MediaListResponseProtocol {

    public var page: Int
    public var totalResults: Int
    public var totalPages: Int
    public var results: [T]

}

extension MediaListResponse {
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
