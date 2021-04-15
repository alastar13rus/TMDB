//
//  DataSourceProtocol.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.04.2021.
//

import Foundation

protocol DataSourceProtocol {
    
    associatedtype DataSource
    static func dataSource() -> DataSource
    
}
