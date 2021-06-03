//
//  PeopleListResponse.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 26.05.2021.
//

import Foundation

public struct PeopleListResponse: Decodable {
    
    public var page: Int
    public var totalResults: Int
    public var totalPages: Int
    public var results: [PeopleModel]

}

extension PeopleListResponse {
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
