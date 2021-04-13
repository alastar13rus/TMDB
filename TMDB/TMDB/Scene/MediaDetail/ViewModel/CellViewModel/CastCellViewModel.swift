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

class CastCellViewModelSection: AnimatableSectionModelType, IdentifiableType, Equatable {
    
    var identity: String { self.title }
    let title: String
    var items: [CastCellViewModel]
    
    init(title: String, items: [CastCellViewModel]) {
        self.title = title
        self.items = items
    }
    
    required init(original: CastCellViewModelSection, items: [CastCellViewModel]) {
        self.title = original.title
        self.items = items
        
    }
    
    static func ==(lhs: CastCellViewModelSection, rhs: CastCellViewModelSection) -> Bool {
        return lhs == rhs
    }
    
}

class CastCellViewModel {
    
//    MARK: - Properties
    let gender: Int
    let id: Int
    let name: String
    let popularity: Float
    let profilePath: String?
    let character: String
    let creditID: String
    var order: Int
    
//    MARK: - Init
    
    init(_ model: CastModel) {
        self.gender = model.gender
        self.id = model.id
        self.name = model.name
        self.popularity = model.popularity
        self.profilePath = model.profilePath
        self.character = model.character
        self.creditID = model.creditID
        self.order = model.order
    }
    
    init(_ vm: CastCellViewModel) {
        self.gender = vm.gender
        self.id = vm.id
        self.name = vm.name
        self.popularity = vm.popularity
        self.profilePath = vm.profilePath
        self.character = vm.character
        self.creditID = vm.creditID
        self.order = 99
    }
    
//    MARK: - Methods
    
    func profileImageData(completion: @escaping (Data?) -> Void) {
        
            guard let profilePath = profilePath else {
                completion(nil)
                return
            }
            
            let profileAbsolutePath = ImageURL.profile(.w185, profilePath).fullURL
            guard let path = profileAbsolutePath else {
                completion(nil)
                return
            }
            path.downloadImageData(completion: { (data) in
                completion(data)
            })
    }
}

extension CastCellViewModel: IdentifiableType, Equatable {
    
    var identity: String { self.creditID }
    
    static func ==(lhs: CastCellViewModel, rhs: CastCellViewModel) -> Bool {
        return lhs.creditID == rhs.creditID
    }
    
}
