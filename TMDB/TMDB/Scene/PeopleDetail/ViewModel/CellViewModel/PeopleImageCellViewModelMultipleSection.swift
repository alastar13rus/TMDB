//
//  PeopleImageCellViewModelMultipleSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.04.2021.
//

import Foundation
import RxDataSources

struct PeopleImageCellViewModelMultipleSection: AnimatableSectionModelType {
    
    let title: String
    let items: [PeopleImageCellViewModel]
    
    init(original: PeopleImageCellViewModelMultipleSection, items: [PeopleImageCellViewModel]) {
        self = original
    }
    
    init(title: String, items: [PeopleImageCellViewModel]) {
        self.title = title
        self.items = items
    }
    
}

extension PeopleImageCellViewModelMultipleSection: IdentifiableType {
    var identity: String { return title }
}
