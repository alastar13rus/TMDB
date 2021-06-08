//
//  PeopleModel.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 26.05.2021.
//

import Foundation

public enum KnownFor: Decodable {
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
        case .movie: self = .movie(try container.decode(MovieModel.self))
        case .tv: self = .tv(try container.decode(TVModel.self))
        default: fatalError("Error decoding PeopleModel (knownFor)")
        }
        
    }
}

public struct PeopleModel: Decodable {

    public let adult: Bool
    public let id: Int
    public let knownFor: [KnownFor]
    public let name: String
    public let popularity: Float
    public let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case knownFor = "known_for"
        case name
        case popularity
        case profilePath = "profile_path"
    }
    
    public init(
        adult: Bool,
        id: Int,
        knownFor: [KnownFor],
        name: String,
        popularity: Float,
        profilePath: String?
    ) {
        self.adult = adult
        self.id = id
        self.knownFor = []
        self.name = name
        self.popularity = popularity
        self.profilePath = profilePath
    }
    
    public init(_ detailModel: PeopleDetailModel)
    {
        self.adult = detailModel.adult
        self.id = detailModel.id
        self.knownFor = []
        self.name = detailModel.name
        self.popularity = detailModel.popularity
        self.profilePath = detailModel.profilePath
    }
}
