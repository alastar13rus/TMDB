//
//  SearchAPI.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import Foundation

public protocol SearchAPI: class {
    func mediaGenreList(mediaType: MediaType) -> Domain.Endpoint
    func multiSearch(_ query: String, page: Int) -> Domain.Endpoint
}
