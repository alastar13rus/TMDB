//
//  PeopleShortListViewModelSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import Foundation
import RxDataSources

struct PeopleShortListViewModelSection: AnimatableSectionModelType {
    
    let title: String
    let items: [PeopleCellViewModel]
    
    init(original: PeopleShortListViewModelSection, items: [PeopleCellViewModel]) {
        self = original
    }
    
    init(title: String, items: [PeopleCellViewModel]) {
        self.title = title
        self.items = items
    }
    
}

extension PeopleShortListViewModelSection: IdentifiableType {
    var identity: String { return title }
}
