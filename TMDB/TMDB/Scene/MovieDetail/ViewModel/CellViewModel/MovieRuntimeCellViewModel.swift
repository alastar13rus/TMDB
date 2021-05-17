//
//  MovieRuntimeCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.04.2021.
//

import Foundation
import Domain

struct MovieRuntimeCellViewModel {
    
    let id: String
    let runtime: Int?
    
    var runtimeText: String {
        guard let runtime = runtime else { return "" }
        switch runtime {
        case 60...:
            let hours = Int(Double(runtime / 60))
            let minutes = runtime % 60
            return minutes == 0 ?
                "\(hours) час" :
                "\(hours) час \(minutes) мин"
        default:
            return "\(runtime) мин"
        }
    }
    
    
    init(_ model: MovieDetailModel) {
        self.id = String(model.id)
        self.runtime = model.runtime
    }
    
}
