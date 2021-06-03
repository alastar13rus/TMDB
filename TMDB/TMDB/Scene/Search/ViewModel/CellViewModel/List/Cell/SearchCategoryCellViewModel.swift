//
//  SearchCategoryCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 26.05.2021.
//

import Foundation
import Domain
import RxDataSources

struct SearchCategoryCellViewModel {
    
//    MARK: - Properties
    let title: String
    let type: SearchCategory
    
//    MARK: - Init
    init(_ model: SearchCategory) {
        switch model {
        case .movieListByGenres(let title):
            self.title = title
            self.type = .movieListByGenres(title: title)
        case .movieListByYears(let title):
            self.title = title
            self.type = .movieListByYears(title: title)
        case .tvListByGenres(let title):
            self.title = title
            self.type = .tvListByGenres(title: title)
        case .tvListByYears(let title):
            self.title = title
            self.type = .tvListByYears(title: title)
        }
    }
}

extension SearchCategoryCellViewModel: IdentifiableType {
    var identity: String { title }
}

extension SearchCategoryCellViewModel: Equatable {
    static func ==(lhs: SearchCategoryCellViewModel, rhs: SearchCategoryCellViewModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}

