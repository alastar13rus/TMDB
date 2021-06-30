//
//  TVEpisodeOverviewCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.05.2021.
//

import Foundation
import Domain

struct TVEpisodeOverviewCellViewModel {
    
// MARK: - Properties
    let id: String
    let overview: String
    
// MARK: - Init
    init(_ model: TVEpisodeDetailModel) {
        self.id = "\(model.id)"
        self.overview = model.overview
    }
}
