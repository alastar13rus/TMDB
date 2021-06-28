//
//  PeopleCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 25.05.2021.
//

import Foundation
import Domain
import RxDataSources

class PeopleCellViewModel {
    
//    MARK: - Properties
    public let adult: Bool
    public let id: String
    public let knownFor: String
    public let name: String
    public let popularity: Float
    public let profilePath: String?
    
    var profileURL: URL? {
        ImageURL.profile(.w185, profilePath).fullURL
    }
    
    
//    MARK: - Init
    init(_ model: PeopleModel) {
        self.adult = model.adult
        self.id = "\(model.id)"
        
        self.knownFor = model.knownFor.map {
            switch $0 {
            case .movie(let movie): return movie.title
            case .tv(let tv): return tv.name
            }
        }.joined(separator: ", ")
        
        self.name = model.name
        self.popularity = model.popularity
        self.profilePath = model.profilePath
    }
}

extension PeopleCellViewModel: IdentifiableType {
    var identity: String { id }
}

extension PeopleCellViewModel: Equatable {
    static func ==(lhs: PeopleCellViewModel, rhs: PeopleCellViewModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}
