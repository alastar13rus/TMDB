//
//  TVSeasonOverviewCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 04.05.2021.
//

import Foundation

struct TVSeasonOverviewCellViewModel {
    
//    MARK: - Properties
    let id: String
    let overview: String
    
//    MARK: - Init
    init(_ model: TVSeasonDetailModel) {
        self.id = "\(model.id)"
        self.overview = model.overview
    }
}
