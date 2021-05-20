//
//  Dictionary+Extensions.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.05.2021.
//

import Foundation

extension Dictionary {
    mutating func merge(_ dict: [Key: Value]) -> [Key: Value] {
        dict.forEach { updateValue($0.value, forKey: $0.key) }
        return self
    }
}
