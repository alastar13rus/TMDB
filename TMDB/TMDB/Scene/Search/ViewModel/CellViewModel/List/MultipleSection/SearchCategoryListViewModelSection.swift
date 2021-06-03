//
//  SearchCategoryListViewModelSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import Foundation
import RxDataSources

struct SearchCategoryListViewModelSection: AnimatableSectionModelType {
    
    let title: String
    let items: [SearchCategoryCellViewModel]
    
    init(original: SearchCategoryListViewModelSection, items: [SearchCategoryCellViewModel]) {
        self = original
    }
    
    init(title: String, items: [SearchCategoryCellViewModel]) {
        self.title = title
        self.items = items
    }
    
}

extension SearchCategoryListViewModelSection: IdentifiableType {
    var identity: String { return title }
}
