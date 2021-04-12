//
//  TVStatusCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 10.04.2021.
//

import Foundation

struct TVStatusCellViewModel {
    
    let id: String
    let status: String
    
    init(_ model: TVDetailModel) {
        self.id = String(model.id)
        self.status = model.status
    }
    
}
