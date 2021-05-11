//
//  String+Extensions.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 01.05.2021.
//

import Foundation

extension String {
    func toRussianDate() -> (string: String, date: Date?) {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: self) else { return (string: "", date: nil) }
        
        let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter2.string(from: date)
        
        return (string: dateString, date: date)
    }
}
