//
//  MediaListResponseProtocol.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 15.03.2021.
//

import Foundation

protocol MediaListResponseProtocol: Decodable {
    
    associatedtype MediaProtocol
    
    var page: Int { get }
    var totalResults: Int { get }
    var totalPages: Int { get }
    var results: [MediaProtocol] { get }
}

protocol MovieListResponseProtocol: MediaListResponseProtocol {
    
    associatedtype MovieProtocol
    
    var page: Int { get }
    var totalResults: Int { get }
    var totalPages: Int { get }
    var results: [MovieProtocol] { get }
}

protocol TVListResponseProtocol: MediaListResponseProtocol {
    
    associatedtype TVProtocol
    
    var page: Int { get }
    var totalResults: Int { get }
    var totalPages: Int { get }
    var results: [TVProtocol] { get }
}
