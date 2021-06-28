//
//  MoviePosterWrapperCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.04.2021.
//

import Foundation
import RxDataSources
import Domain

struct MoviePosterWrapperCellViewModel {
    
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
    
    init(_ model: MovieDetailModel) {
        self.id = String(model.id)
        self.title = model.title
        self.tagline = model.tagline
        self.voteAverage = CGFloat(model.voteAverage * 10)
        self.posterPath = model.posterPath
        self.backdropPath = model.backdropPath
        
        if let releaseDate = model.releaseDate {
            self.releaseYear = String(releaseDate.prefix(4))
        } else {
            self.releaseYear = ""
        }
    }
}
