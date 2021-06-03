//
//  MediaStatusCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 10.04.2021.
//

import Foundation
import Domain

struct MediaStatusCellViewModel {
    
    let id: String
    let status: String
    
    init(_ model: MediaDetailProtocol) {
        self.id = String(model.id)
        self.status = model.status
    }
    
}
