//
//  PeopleDetailAPI.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation

public protocol PeopleDetailAPI: AnyObject {
    func details(personID: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage]) -> Endpoint
}
