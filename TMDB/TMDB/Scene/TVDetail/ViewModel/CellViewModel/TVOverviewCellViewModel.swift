//
//  TVOverviewCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 09.04.2021.
//

import Foundation

struct TVOverviewCellViewModel {
    
    let id: String
    let overview: String
    
    
    init(_ model: TVDetailModel) {
        self.id = String(model.id)
        self.overview = model.overview
    }
    
}
