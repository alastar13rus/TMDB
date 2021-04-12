//
//  TVCastListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources

class TVCastCellViewModelSection: AnimatableSectionModelType, IdentifiableType, Equatable {
    
    var identity: String { self.title }
    let title: String
    var items: [TVCastCellViewModel]
    
    init(title: String, items: [TVCastCellViewModel]) {
        self.title = title
        self.items = items
    }
    
    required init(original: TVCastCellViewModelSection, items: [TVCastCellViewModel]) {
        self.title = original.title
        self.items = items
        
    }
    
    static func ==(lhs: TVCastCellViewModelSection, rhs: TVCastCellViewModelSection) -> Bool {
        return lhs == rhs
    }
    
}

class TVCastCellViewModel {
    
//    MARK: - Properties
    let gender: Int
    let id: Int
    let name: String
    let popularity: Float
    let profilePath: String?
    let character: String
    let creditID: String
    var order: Int
    
    var profileAbsolutePath: URL? {
        return ImageURL.profile(.w185, profilePath).fullURL
    }
    
//    MARK: - Init
    
    init(_ model: TVCastModel) {
        self.gender = model.gender
        self.id = model.id
        self.name = model.name
        self.popularity = model.popularity
        self.profilePath = model.profilePath
        self.character = model.character
        self.creditID = model.creditID
        self.order = model.order
    }
    
    init(_ vm: TVCastCellViewModel) {
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
    
    func profileImageData(completion: @escaping (Data) -> Void) {
        profileAbsolutePath?.downloadImageData(completion: { (data) in
            completion(data)
        })
    }
    
    func changeOrder(to newOrder: Int) {
        self.order = newOrder
    }
    
}

extension TVCastCellViewModel: IdentifiableType, Equatable {
    
    var identity: String { self.creditID }
    
    static func ==(lhs: TVCastCellViewModel, rhs: TVCastCellViewModel) -> Bool {
        return lhs.creditID == rhs.creditID
    }
    
}
