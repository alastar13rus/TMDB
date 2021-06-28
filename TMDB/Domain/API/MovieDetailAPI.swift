//
//  MovieDetailAPI.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 18.05.2021.
//

import Foundation

public protocol MovieDetailAPI: AnyObject {
    func details(mediaID: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage]) -> Domain.Endpoint
    func credits(mediaID: String) -> Domain.Endpoint
    func images(mediaID: String) -> Domain.Endpoint
    func videos(mediaID: String) -> Domain.Endpoint
    func recommendations(mediaID: String) -> Domain.Endpoint
}
