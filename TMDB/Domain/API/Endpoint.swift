//
//  Request.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation

public protocol Endpoint {
    var method: HTTPMethod { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}
