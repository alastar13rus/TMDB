//
//  MultiSearchResponse.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 31.05.2021.
//

import Foundation

public struct MultiSearchResponse: Decodable {

    public var page: Int
    public var totalResults: Int
    public var totalPages: Int
    public var results: [SearchMediaItem]

}

extension MultiSearchResponse {
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

public enum SearchMediaItem: Decodable {
    
    case person(PeopleModel)
    case movie(MovieModel)
    case tv(TVModel)
    
    enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let container2 = try decoder.container(keyedBy: CodingKeys.self)
        let mediaType = try container2.decode(MediaType.self, forKey: .mediaType)
        switch mediaType {
        case .movie:  self = .movie(try container.decode(MovieModel.self))
        case .tv: self = .tv(try container.decode(TVModel.self))
        case .person: self = .person(try container.decode(PeopleModel.self))
        default: fatalError("Decoding error")
        }

    }
    
}
