//
//  Int+Extensions.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation

extension Int {
    func correctlyEnding(withWord word: String) -> String {
        var resultString = "\(self) \(word)"
        switch (self / 10, self % 10) {
        case (1, 1...4), (11, 1...4):
            resultString += "ов"
        case (0, 1), (2...10, 1), (11..., 1):
            break
        case (0, 2...4), (2...10, 2...4), (11..., 2...4):
            resultString += "а"
        case (_, 0), (_, 5...9):
            resultString += "ов"
        default:
            break
        }
        return resultString
    }
}
