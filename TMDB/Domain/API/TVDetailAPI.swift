//
//  TVDetailAPI.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation

public protocol TVDetailAPI: class {
    func details(mediaID: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage]) -> Endpoint
    func aggregateCredits(mediaID: String) -> Endpoint
    func credits(mediaID: String) -> Endpoint
    func videos(mediaID: String) -> Endpoint
    func recommendations(mediaID: String) -> Endpoint
}
