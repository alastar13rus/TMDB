//
//  FilterOptionMediaByGenreCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 30.05.2021.
//

import Foundation
import Domain
import RxDataSources

class FilterOptionMediaByGenreCellViewModel {
    
//    MARK: - Properties
    let genreID: String
    let genreName: String
    let mediaType: Domain.MediaType
    
    var title: String { genreName }
    
//    MARK: - Init
    init(_ model: GenreModel, mediaType: MediaType) {
        self.genreID = String(model.id)
        self.genreName = model.name.capitalized
        self.mediaType = mediaType
    }
    
}

extension FilterOptionMediaByGenreCellViewModel: IdentifiableType {
    var identity: String { genreID }
}

extension FilterOptionMediaByGenreCellViewModel: Equatable {
    static func ==(lhs: FilterOptionMediaByGenreCellViewModel, rhs: FilterOptionMediaByGenreCellViewModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}
