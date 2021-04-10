//
//  TVInfoCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 10.04.2021.
//

import Foundation

struct TVInfoCellViewModel {
    
    let id: String
    let episodeRunTime: Int
    let genres: String
    let creators: String
    let status: String
    
    var runtime: String {
        var result = ""
        switch episodeRunTime {
        case 60...:
            let hours = Int(Double(episodeRunTime / 60))
            let minutes = episodeRunTime % 60
            result = minutes == 0 ?
                "\(hours) час" :
                "\(hours) час \(minutes) мин"
        default:
            result = "\(episodeRunTime) мин"
        }
        
        return "Продолжительность: \(result)"
    }
    
    
    init(_ model: TVDetailModel) {
        self.id = String(model.id)
        self.episodeRunTime = model.episodeRunTime[0]
        self.genres = "Жанры: " + model.genres.map { $0.name.localizedLowercase }.joined(separator: ", ")
        self.creators = !model.createdBy.isEmpty ? "Создатели: " + model.createdBy.map { $0.name }.joined(separator: ", ") : ""
        self.status = "Статус: " + model.status
    }
    
}
