//
//  GenresViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 10.04.2021.
//

import Foundation
import Domain

struct GenresCellViewModel {
    
    let id: String
    let genres: String
    
    init(_ model: MediaDetailProtocol) {
        self.id = String(model.id)
        self.genres = model.genres.map { $0.name.localizedLowercase }.joined(separator: ", ")
    }
    
}
