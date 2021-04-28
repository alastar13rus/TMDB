//
//  Array+Extensions.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.04.2021.
//

import Foundation
import RxDataSources

extension Array where Array.Element: AnimatableSectionModelType {
    
    func buildSection<T, U: Decodable>(withModel model: U,
                             andAction action: ((U, [T]) -> [T])) -> [T] {
        guard let self = self as? [T] else { return [] }
        return action(model, self as [T])
    }

    func buildSection<T, U: Decodable, V>(withModel model: U,
                                          andAction action: ((U, [T], V) -> [T]), param: V) -> [T] {
        guard let self = self as? [T] else { return [] }
        return action(model, self as [T], param)
    }

}

extension Array where Array.Element: (Decodable & IdentifiableType) {
    func toUnique() -> [Element] {
        var dict = [Int:Element]()
        self.enumerated().forEach { dict[$0.element.identity as! Int] = $0.element }
        return dict.map { $0.value }
    }
}

