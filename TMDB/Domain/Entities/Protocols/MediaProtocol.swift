//
//  MediaProtocol.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 15.03.2021.
//

import Foundation

public protocol MediaProtocol: Decodable, Comparable {
    
    var id: Int { get }
    var popularity: Float? { get }
    var voteCount: Int { get }
    var posterPath: String? { get }
    var backdropPath: String? { get }
    var originalLanguage: String { get }
    var genreIds: [Int] { get }
    var voteAverage: Float { get }
    var overview: String { get }
}


public protocol MovieProtocol: MediaProtocol {
    var adult: Bool { get }
    var releaseDate: String? { get }
    var genreIds: [Int] { get }
    var id: Int { get }
    var originalTitle: String { get }
    var title: String { get }
    var video: Bool { get }
    
}

public protocol TVProtocol: MediaProtocol {
    
    var firstAirDate: String? { get }
    var originCountry: [String] { get }
    var name: String { get }
    var originalName: String { get }
    
}
