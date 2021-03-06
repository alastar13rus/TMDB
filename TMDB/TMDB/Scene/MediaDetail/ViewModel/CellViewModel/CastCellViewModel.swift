//
//  CastListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources
import Domain

class CastCellViewModel {
    
//    MARK: - Properties
    let gender: Int
    let id: String
    let name: String
    let popularity: Float
    let profilePath: String?
    let character: String
    let creditID: String
    var order: Int
    
    var profileURL: URL? {
        ImageURL.profile(.w185, profilePath).fullURL
    }
    
//    MARK: - Init
    
    init(_ model: CastModel) {
        self.gender = model.gender
        self.id = "\(model.id)"
        self.name = model.name
        self.popularity = model.popularity
        self.profilePath = model.profilePath
        self.character = model.character
        self.creditID = model.creditID
        self.order = model.order
    }
}

extension CastCellViewModel: IdentifiableType, Equatable, Comparable {
    var identity: String { self.creditID }
    
    static func ==(lhs: CastCellViewModel, rhs: CastCellViewModel) -> Bool {
        return lhs.creditID == rhs.creditID
    }
    
    static func < (lhs: CastCellViewModel, rhs: CastCellViewModel) -> Bool {
        return lhs.name < rhs.name
    }
    
}
