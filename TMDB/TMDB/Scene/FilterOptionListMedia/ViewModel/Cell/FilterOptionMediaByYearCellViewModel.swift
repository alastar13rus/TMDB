//
//  FilterOptionMediaByYearCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.05.2021.
//

import Foundation
import Domain
import RxDataSources

class FilterOptionMediaByYearCellViewModel {
    
//    MARK: - Properties
    let year: String
    let mediaType: Domain.MediaType
    
    var title: String {
        switch mediaType {
        case .movie:  return "Фильмы \(year) года"
        case .tv: return "Сериалы \(year) года"
        default: return ""
        }
    }
    
//    MARK: - Init
    init(_ model: FilterOptionMediaByYearModel) {
        self.year = model.year
        self.mediaType = model.mediaType
    }
    
}

extension FilterOptionMediaByYearCellViewModel: IdentifiableType {
    var identity: String { year }
}

extension FilterOptionMediaByYearCellViewModel: Equatable {
    static func ==(lhs: FilterOptionMediaByYearCellViewModel, rhs: FilterOptionMediaByYearCellViewModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}
