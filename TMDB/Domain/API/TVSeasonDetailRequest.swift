//
//  TVSeasonDetailAPI.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation

public protocol TVSeasonDetailAPI: class {
    func details(mediaID: String, seasonNumber: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage]) -> Request
    func aggregateCredits(mediaID: String, seasonNumber: String) -> Request
    func videos(mediaID: String, seasonNumber: String) -> Request
}
