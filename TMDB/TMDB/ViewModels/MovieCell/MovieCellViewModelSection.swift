//
//  MovieCellViewModelSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 17.03.2021.
//

import Foundation
import RxDataSources

struct MovieCellViewModelSection: AnimatableSectionModelType {
    
    typealias Item = MovieCellViewModel
    
    var items: [Item]
    let header: String
    
    init(header: String, items: [Item]) {
        self.header = header
        self.items = items
    }
    
    init(original: MovieCellViewModelSection, items: [MovieCellViewModel]) {
        self = original
        self.items = items
    }
    
    var identity: String { header }
    
}
