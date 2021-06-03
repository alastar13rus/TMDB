//
//  MediaType.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 28.04.2021.
//

import Foundation

public enum MediaType: String, Decodable {
    case movie
    case tv
    case tvSeason
    case tvEpisode
    case person
}
