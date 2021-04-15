//
//  CastListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import Foundation
import RxSwift
import RxDataSources

struct CastListViewModel: AnimatableSectionModelType, IdentifiableType {
    
    var identity: String { return title }
    let title: String
    let items: [CastCellViewModel]
    
    var sectionedItems: Observable<[CastCellViewModelSection]> {
        return .just([.init(title: title, items: items)])
    }
    
    init(original: CastListViewModel, items: [CastCellViewModel]) {
        self.title = original.title
        self.items = items
    }
    
    init(title: String, items: [CastCellViewModel]) {
        self.title = title
        self.items = items
    }
}
