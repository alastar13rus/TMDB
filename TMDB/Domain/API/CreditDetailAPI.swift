//
//  CreditDetailAPI.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 20.05.2021.
//

import Foundation

public protocol CreditDetailAPI: class {
    func details(creditID: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage]) -> Endpoint
}
