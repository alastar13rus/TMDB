//
//  PeopleListAPI.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import Foundation

public protocol PeopleListAPI: AnyObject {
    func popular() -> Endpoint
}
