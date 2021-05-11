//
//  ButtonCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation
import RxDataSources

enum ButtonCellType: String {
    case trailer
}

class ButtonCellViewModel: Equatable, IdentifiableType {
    
    let title: String
    let type: ButtonCellType
    
    var identity: String { return title }
    
    init(title: String, type: ButtonCellType) {
        self.title = title
        self.type = type
    }
    
    static func ==(lhs: ButtonCellViewModel, rhs: ButtonCellViewModel) -> Bool {
        return lhs.type == rhs.type
    }
    
}
