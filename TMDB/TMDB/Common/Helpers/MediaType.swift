//
//  MediaType.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 28.04.2021.
//

import Foundation

enum MediaType: String, Decodable {
    case movie
    case tv
    case tvSeason
    case tvEpisode
}
