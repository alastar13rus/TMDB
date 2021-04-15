//
//  CrewListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 13.04.2021.
//

import Foundation
import RxSwift
import RxDataSources

struct CrewListViewModel: AnimatableSectionModelType, IdentifiableType {
    
    var identity: String { return title }
    let title: String
    let items: [CrewCellViewModel]
    
    var sectionedItems: Observable<[CrewCellViewModelSection]> {
        return .just([.init(title: title, items: items)])
    }
    
    init(original: CrewListViewModel, items: [CrewCellViewModel]) {
        self.title = original.title
        self.items = items
    }
    
    init(title: String, items: [CrewCellViewModel]) {
        self.title = title
        self.items = items
    }
}
