//
//  MovieCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 17.03.2021.
//

import Foundation
import RxDataSources

struct MovieCellViewModel {
    let id: String
    let title: String
    let overview: String
    
    init(_ model: MovieModel) {
        self.id = String(model.id)
        self.title = model.title
        self.overview = model.overview
    }
}

extension MovieCellViewModel: IdentifiableType {
    var identity: String { id }
    
    
}

extension MovieCellViewModel: Equatable {
    
}
