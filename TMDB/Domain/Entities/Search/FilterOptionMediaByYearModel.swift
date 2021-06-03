//
//  FilterOptionMediaByYearModel.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 29.05.2021.
//

import Foundation

public struct FilterOptionMediaByYearModel: Decodable {
    public let year: String
    public let mediaType: MediaType
    
    public init(year: Int, mediaType: MediaType) {
        self.year = String(year)
        self.mediaType = mediaType
    }
}
