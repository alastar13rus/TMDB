//
//  NetworkManagerProtocol.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 15.03.2021.
//

import Foundation

protocol NetworkManagerProtocol: class {
    func request<T: Decodable>(_ api: API, completion : @escaping (Result<T,Error>) -> Void)
}
