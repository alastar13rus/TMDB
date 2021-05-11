//
//  AggregateCrewCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources

class TVAggregateCrewCellViewModelSection: AnimatableSectionModelType, IdentifiableType, Equatable {
    
    var identity: String { self.title }
    let title: String
    var items: [AggregateCrewCellViewModel]
    
    init(title: String, items: [AggregateCrewCellViewModel]) {
        self.title = title
        self.items = items
    }
    
    required init(original: TVAggregateCrewCellViewModelSection, items: [AggregateCrewCellViewModel]) {
        self.title = original.title
        self.items = items
        
    }
    
    static func ==(lhs: TVAggregateCrewCellViewModelSection, rhs: TVAggregateCrewCellViewModelSection) -> Bool {
        return lhs.items == rhs.items && lhs.identity == rhs.identity
    }
    
}

class AggregateCrewCellViewModel {
    
//    MARK: - Properties
    let gender: Int
    let id: String
    let name: String
    let popularity: Float
    let profilePath: String?
    let department: String
    let jobs: String
    let knownForDepartment: String?
    let totalEpisodeCount: Int
    
    var totalEpisodeCountText: String {
        totalEpisodeCount.correctlyEnding(withWord: "эпизод")
    }
    
//    MARK: - Init
    
    init(_ model: TVAggregateCrewModel) {
        self.gender = model.gender
        self.id = "\(model.id)"
        self.name = model.name
        self.popularity = model.popularity
        self.profilePath = model.profilePath
        self.knownForDepartment = model.knownForDepartment
        self.jobs = model.jobs.filter { !$0.job.isEmpty }.map { $0.job }.joined(separator: ", ")
        self.department = model.department
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

extension AggregateCrewCellViewModel: IdentifiableType, Equatable {
    
    var identity: String { return "\(self.id)" }
    
    static func ==(lhs: AggregateCrewCellViewModel, rhs: AggregateCrewCellViewModel) -> Bool {
        return lhs.identity == rhs.identity
    }
    
}
