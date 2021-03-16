//
//  API.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 15.03.2021.
//

import Foundation

protocol API {
    var scheme: String { get }
    var host: String { get }
    var method: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
}
