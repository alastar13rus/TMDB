//
//  TVListAPI.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation

public protocol TVListAPI: MediaListAPI {
    func topRated(page: Int) -> Endpoint
    func popular(page: Int) -> Endpoint
    func onTheAir(page: Int) -> Endpoint
    func airingToday(page: Int) -> Endpoint
}
