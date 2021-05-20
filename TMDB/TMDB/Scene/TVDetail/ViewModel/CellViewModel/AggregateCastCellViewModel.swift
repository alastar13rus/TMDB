//
//  AggregateCastCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources
import Domain

class TVAggregateCastCellViewModelSection: AnimatableSectionModelType, IdentifiableType, Equatable {
    
    var identity: String { self.title }
    let title: String
    var items: [AggregateCastCellViewModel]
    
    init(title: String, items: [AggregateCastCellViewModel]) {
        self.title = title
        self.items = items
    }
    
    required init(original: TVAggregateCastCellViewModelSection, items: [AggregateCastCellViewModel]) {
        self.title = original.title
        self.items = items
        
    }
    
    static func ==(lhs: TVAggregateCastCellViewModelSection, rhs: TVAggregateCastCellViewModelSection) -> Bool {
        return lhs.items == rhs.items && lhs.identity == rhs.identity
    }
    
}

class AggregateCastCellViewModel {
    
//    MARK: - Properties
    let gender: Int
    let id: String
    let name: String
    let popularity: Float
    let profilePath: String?
    let roles: String
    let knownForDepartment: String?
    let totalEpisodeCount: Int
    
    var totalEpisodeCountText: String {
        totalEpisodeCount.correctlyEnding(withWord: "эпизод")
    }
    
//    MARK: - Init
    
    init(_ model: TVAggregateCastModel) {
        self.gender = model.gender
        self.id = "\(model.id)"
        self.name = model.name
        self.popularity = model.popularity
        self.profilePath = model.profilePath
        self.knownForDepartment = model.knownForDepartment
        self.roles = model.roles.filter { !$0.character.isEmpty }.map { $0.character }.joined(separator: ", ")
        self.totalEpisodeCount = model.totalEpisodeCount
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

extension AggregateCastCellViewModel: IdentifiableType, Equatable {
    
    var identity: String { return "\(self.id)" }
    
    static func ==(lhs: AggregateCastCellViewModel, rhs: AggregateCastCellViewModel) -> Bool {
        return lhs.identity == rhs.identity
    }
    
}
