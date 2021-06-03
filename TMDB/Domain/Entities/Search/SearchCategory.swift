//
//  SearchCategory.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import Foundation

public enum SearchCategory {
    case movieListByYears(title: String)
    case movieListByGenres(title: String)
    
    case tvListByYears(title: String)
    case tvListByGenres(title: String)
}
