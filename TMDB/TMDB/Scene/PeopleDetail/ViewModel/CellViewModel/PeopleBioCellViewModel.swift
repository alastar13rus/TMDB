//
//  PeopleBioCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.04.2021.
//

import Foundation
import Domain

struct PeopleBioCellViewModel {
    
    //    MARK: - Properties
    let id: String
    let bio: String
    
    //    MARK: - Init
    init(_ model: PeopleDetailModel) {
        self.id = "\(model.id)"
        self.bio = model.biography
    }
    
    
}
