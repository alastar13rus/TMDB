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
    
//    MARK: - Methods
    func profileImageData(completion: @escaping (Data?) -> Void) {
        guard let profilePath = profilePath else { completion(nil); return }
        
        guard let profileAbsoluteURL = ImageURL.profile(.w185, profilePath).fullURL else { completion(nil); return }
        
        profileAbsoluteURL.downloadImageData { (imageData) in
            completion(imageData)
        }
        
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
