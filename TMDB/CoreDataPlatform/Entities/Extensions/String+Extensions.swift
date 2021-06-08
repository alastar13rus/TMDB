//
//  String+Extensions.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 06.06.2021.
//

import Foundation

extension String {
    
    func decodeToArray<T: Decodable>(with type: T.Type) -> [T] {
        let data = Data(self.utf8)
        guard let array = try? JSONDecoder().decode([T].self, from: data) else { return [] }
        return array
    }
}
