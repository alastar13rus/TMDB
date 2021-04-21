//
//  ShowMoreCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.04.2021.
//

import Foundation

enum ShowMoreCellType: String {
    case cast
    case crew
}

class ShowMoreCellViewModel: Equatable {
    
    let title: String
    let type: ShowMoreCellType
    
    init(title: String, type: ShowMoreCellType) {
        self.title = title
        self.type = type
    }
    
    static func ==(lhs: ShowMoreCellViewModel, rhs: ShowMoreCellViewModel) -> Bool {
        return lhs.type == rhs.type
    }
    
}
