//
//  MediaTrailerCellViewModelSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 30.04.2021.
//

import Foundation
import RxDataSources

struct MediaTrailerCellViewModelSection: AnimatableSectionModelType {
    let title: String
    let items: [MediaTrailerCellViewModel]
    
    init(original: MediaTrailerCellViewModelSection, items: [MediaTrailerCellViewModel]) {
        self.title = original.title
        self.items = items
    }
    
    init(title: String, items: [MediaTrailerCellViewModel]) {
        self.title = title
        self.items = items
    }
}

extension MediaTrailerCellViewModelSection: IdentifiableType {
    var identity: String { return title }
}

extension MediaTrailerCellViewModelSection: Equatable {
    static func ==(lhs: MediaTrailerCellViewModelSection, rhs: MediaTrailerCellViewModelSection) -> Bool {
        return lhs.identity == rhs.identity
    }
}
