//
//  TVSeasonPosterWrapperCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 04.05.2021.
//

import Foundation
import Domain

struct TVSeasonPosterWrapperCellViewModel {
    
// MARK: - Properties
    let airDate: String
    let episodes: [TVEpisodeDetailModel]
    let name: String
    let overview: String
    let id: String
    let posterPath: String?
    let seasonNumber: String
    
    var airYear: String { "\(airDate.prefix(4))" }
    
    var posterURL: URL? {
        ImageURL.poster(.w500, posterPath).fullURL
    }
    
// MARK: - Init
    init(_ model: TVSeasonDetailModel) {
        self.airDate = model.airDate ?? ""
        self.episodes = model.episodes
        self.name = model.name
        self.overview = model.overview
        self.id = "\(model.id)"
        self.posterPath = model.posterPath
        self.seasonNumber = "\(model.seasonNumber)"
    }
}
