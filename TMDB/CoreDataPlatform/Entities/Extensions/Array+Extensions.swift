//
//  Array+Extensions.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 06.06.2021.
//

import Foundation

extension Array where Element: Encodable {
    
    func encodeToString() -> String {
        guard let data = try? JSONEncoder().encode(self),
              let string = String(data: data, encoding: .utf8) else { return "" }
        return string
    }
}
