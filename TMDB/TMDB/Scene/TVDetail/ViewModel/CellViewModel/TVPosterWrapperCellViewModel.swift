//
//  TVPosterWrapperCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 09.04.2021.
//

import Foundation
import RxDataSources
import Domain

struct TVPosterWrapperCellViewModel {
    
    let id: String
    let title: String
    let tagline: String
    let voteAverage: CGFloat
    let posterPath: String?
    let backdropPath: String?
    let releaseYear: String
    
    var posterURL: URL? {
        ImageURL.poster(.w500, posterPath).fullURL
    }
    
    init(_ model: TVDetailModel) {
        self.id = String(model.id)
        self.title = model.name
        self.tagline = model.tagline
        self.voteAverage = CGFloat(model.voteAverage * 10)
        self.posterPath = model.posterPath
        self.backdropPath = model.backdropPath

        let firstYear = model.firstAirDate.prefix(4)
        let lastYear = model.lastAirDate.prefix(4)
        
        switch true {
        case firstYear < lastYear :
            self.releaseYear = "\(firstYear) - \(lastYear)"
        default:
            self.releaseYear = "\(firstYear)"
        }
    }
}
