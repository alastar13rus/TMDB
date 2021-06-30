//
//  MediaOverviewCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 09.04.2021.
//

import Foundation
import Domain

struct MediaOverviewCellViewModel {
    
    let id: String
    let overview: String
    
    init(_ model: MediaDetailProtocol) {
        self.id = String(model.id)
        self.overview = model.overview
    }
    
}
