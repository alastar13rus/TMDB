//
//  MediaTrailerCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 30.04.2021.
//

import Foundation
import RxDataSources
import Domain

struct MediaTrailerCellViewModel {
    
// MARK: - Properties
    let id: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
    
// MARK: - Init
    init(_ model: VideoModel) {
        self.id = model.id
        self.key = model.key
        self.name = model.name
        self.site = model.site
        self.size = model.size
        self.type = model.type
    }
}

extension MediaTrailerCellViewModel: IdentifiableType {
    var identity: String { return id }
}

extension MediaTrailerCellViewModel: Equatable {
    static func == (lhs: MediaTrailerCellViewModel, rhs: MediaTrailerCellViewModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}
