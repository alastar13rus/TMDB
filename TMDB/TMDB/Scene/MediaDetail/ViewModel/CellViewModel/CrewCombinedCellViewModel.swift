//
//  CrewCombinedCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 21.04.2021.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources
import Domain

class CrewCombinedCellViewModelSection: AnimatableSectionModelType, IdentifiableType, Equatable {
    
    var identity: String { self.title }
    let title: String
    var items: [CrewCombinedCellViewModel]
    
    init(title: String, items: [CrewCombinedCellViewModel]) {
        self.title = title
        self.items = items
    }
    
    required init(original: CrewCombinedCellViewModelSection, items: [CrewCombinedCellViewModel]) {
        self.title = original.title
        self.items = items
        
    }
    
    static func == (lhs: CrewCombinedCellViewModelSection, rhs: CrewCombinedCellViewModelSection) -> Bool {
        return lhs.items == rhs.items && lhs.identity == rhs.identity
    }
    
}

class CrewCombinedCellViewModel {
    
// MARK: - Properties
    let gender: Int
    let id: String
    let name: String
    let popularity: Float
    let profilePath: String?
    let creditID: String
    let jobs: String
    let knownForDepartment: String?
    
    var profileURL: URL? {
        ImageURL.profile(.w185, profilePath).fullURL
    }
    
// MARK: - Init
    
    init(_ model: GroupedCrewModel) {
        self.gender = model.gender
        self.id = "\(model.id)"
        self.name = model.name
        self.popularity = model.popularity
        self.profilePath = model.profilePath
        self.knownForDepartment = model.knownForDepartment
        self.creditID = model.creditID
        self.jobs = model.jobs
    }
}

extension CrewCombinedCellViewModel: IdentifiableType, Equatable {
    
    var identity: String { self.creditID }
    
    static func == (lhs: CrewCombinedCellViewModel, rhs: CrewCombinedCellViewModel) -> Bool {
        return lhs.creditID == rhs.creditID
    }
    
}
