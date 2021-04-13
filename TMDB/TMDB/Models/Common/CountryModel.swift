//
//  CountryModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 10.04.2021.
//

import Foundation

struct CountryModel: Decodable {
    
    let iso31661: String
    let englishName: String
    let nativeName: String

    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case englishName = "english_name"
        case nativeName = "native_name"
    }
}

struct ProductionCountryModel: Decodable {
    
    let iso31661: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name = "name"
    }
}
