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

extension CastCellViewModel: IdentifiableType, Equatable, Comparable {
    var identity: String { self.creditID }
    
    static func ==(lhs: CastCellViewModel, rhs: CastCellViewModel) -> Bool {
        return lhs.creditID == rhs.creditID
    }
    
    static func < (lhs: CastCellViewModel, rhs: CastCellViewModel) -> Bool {
        return lhs.name < rhs.name
    }
    
}
