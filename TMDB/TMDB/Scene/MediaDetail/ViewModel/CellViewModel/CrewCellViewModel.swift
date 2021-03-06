//
//  CrewCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 13.04.2021.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources
import Domain

class CrewCellViewModelSection: AnimatableSectionModelType, IdentifiableType, Equatable {
    
    var identity: String { self.title }
    let title: String
    var items: [CrewCellViewModel]
    
    init(title: String, items: [CrewCellViewModel]) {
        self.title = title
        self.items = items
    }
    
    required init(original: CrewCellViewModelSection, items: [CrewCellViewModel]) {
        self.title = original.title
        self.items = items
        
    }
    
    static func ==(lhs: CrewCellViewModelSection, rhs: CrewCellViewModelSection) -> Bool {
        return lhs.items == rhs.items && lhs.identity == rhs.identity
    }
    
}

class CrewCellViewModel {
    
//    MARK: - Properties
    let gender: Int
    let id: String
    let name: String
    let popularity: Float
    let profilePath: String?
    let creditID: String
    let department: String
    let job: String
    let knownForDepartment: String?
    
    var profileURL: URL? {
        ImageURL.profile(.w185, profilePath).fullURL
    }
    
//    MARK: - Init
    
    init(_ model: CrewModel) {
        self.gender = model.gender
        self.id = "\(model.id)"
        self.name = model.name
        self.popularity = model.popularity
        self.profilePath = model.profilePath
        self.knownForDepartment = model.knownForDepartment
        self.creditID = model.creditID
        self.department = model.department
        self.job = model.job
    }
}

extension CrewCellViewModel: IdentifiableType, Equatable {
    
    var identity: String { self.creditID }
    
    static func ==(lhs: CrewCellViewModel, rhs: CrewCellViewModel) -> Bool {
        return lhs.creditID == rhs.creditID
    }
    
}
