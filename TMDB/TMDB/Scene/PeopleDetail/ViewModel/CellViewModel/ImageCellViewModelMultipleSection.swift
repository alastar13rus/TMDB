//
//  ImageCellViewModelMultipleSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.04.2021.
//

import Foundation
import RxDataSources

struct ImageCellViewModelMultipleSection: AnimatableSectionModelType {
    
    let title: String
    let items: [ImageCellViewModel]
    
    init(original: ImageCellViewModelMultipleSection, items: [ImageCellViewModel]) {
        self = original
    }
    
    init(title: String, items: [ImageCellViewModel]) {
        self.title = title
        self.items = items
    }
    
}

extension ImageCellViewModelMultipleSection: IdentifiableType {
    var identity: String { return title }
}
