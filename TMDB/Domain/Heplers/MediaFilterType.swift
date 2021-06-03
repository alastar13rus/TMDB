//
//  MediaFilterType.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 01.06.2021.
//

import Foundation

public enum MediaFilterType {
    case byYear(year: String)
    case byGenre(genreID: String, genreName: String)
}
