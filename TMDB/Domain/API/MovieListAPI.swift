//
//  MovieListAPI.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation

public protocol MediaListAPI: AnyObject {
    
}

public protocol MovieListAPI: MediaListAPI {
    func topRated(page: Int) -> Endpoint
    func popular(page: Int) -> Endpoint
    func nowPlaying(page: Int) -> Endpoint
    func upcoming(page: Int) -> Endpoint
}
