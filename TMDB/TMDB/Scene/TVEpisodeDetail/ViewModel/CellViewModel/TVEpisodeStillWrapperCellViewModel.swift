//
//  TVEpisodeStillWrapperCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.05.2021.
//

import Foundation
import Domain

struct TVEpisodeStillWrapperCellViewModel {
    
// MARK: - Properties
    let airDate: String
    let name: String
    let overview: String
    let id: String
    let stillPath: String?
    let episodeNumber: String
    
    var airYear: String { "\(airDate.prefix(4))" }
    
    var stillURL: URL? {
        ImageURL.still(.original, stillPath).fullURL
    }
    
// MARK: - Init
    init(_ model: TVEpisodeDetailModel) {
        self.airDate = model.airDate ?? ""
        self.name = model.name
        self.overview = model.overview
        self.id = "\(model.id)"
        self.stillPath = model.stillPath
        self.episodeNumber = "\(model.episodeNumber)"
    }
}
