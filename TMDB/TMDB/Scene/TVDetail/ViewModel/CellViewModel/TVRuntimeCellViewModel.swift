//
//  TVRuntimeCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 10.04.2021.
//

import Foundation

struct TVRuntimeCellViewModel {
    
    let id: String
    let episodeRunTime: Int
    
    var runtimeText: String {
        switch episodeRunTime {
        case 60...:
            let hours = Int(Double(episodeRunTime / 60))
            let minutes = episodeRunTime % 60
            return minutes == 0 ?
                "\(hours) час" :
                "\(hours) час \(minutes) мин"
        default:
            return "\(episodeRunTime) мин"
        }
    }
    
    
    init(_ model: TVDetailModel) {
        self.id = String(model.id)
        self.episodeRunTime = model.episodeRunTime[0]
    }
    
}
