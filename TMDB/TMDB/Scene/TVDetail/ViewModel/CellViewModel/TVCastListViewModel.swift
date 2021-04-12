//
//  TVCastListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import Foundation
import RxSwift
import RxDataSources

struct TVCastListViewModel: AnimatableSectionModelType, IdentifiableType {
    
    var identity: String { return title }
    let title: String
    let items: [TVCastCellViewModel]
    
    var sectionedItems: Observable<[TVCastCellViewModelSection]> {
        return .just([.init(title: title, items: items)])
    }
    
    init(original: TVCastListViewModel, items: [TVCastCellViewModel]) {
        self.title = original.title
        self.items = items
    }
    
    init(title: String, items: [TVCastCellViewModel]) {
        self.title = title
        self.items = items
    }
}
