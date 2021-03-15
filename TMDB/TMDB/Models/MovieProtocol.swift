//
//  MovieProtocol.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 15.03.2021.
//

import Foundation

protocol MovieProtocol {
    var posterPath: String? { get }
    var adult: Bool { get }
    var overview: String { get }
    var releaseDate: String { get }
    var genreIds: [Int] { get }
    var id: Int { get }
    var originalTitle: String { get }
    var originalLanguage: String { get }
    var title: String { get }
    var backdropPath: String? { get }
    var popularity: Int { get }
    var voteCount: Int { get }
    var video: Bool { get }
    var voteAverage: Int { get }
    
}
