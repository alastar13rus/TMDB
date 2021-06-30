//
//  TVSeasonCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 01.05.2021.
//

import Foundation
import RxDataSources
import Domain

struct TVSeasonCellViewModel {
    
// MARK: - Properties
    let airDate: String
    let episodeCount: Int
    let id: String
    let name: String
    let overview: String
    let posterPath: String?
    let seasonNumber: String
    
    var episodeCountText: String {
        episodeCount.correctlyEnding(withWord: "эпизод")
    }
    
    var airDateText: String {
        guard let airDate = airDate.toRussianDate().date else { return "" }
        return (airDate > Date()) ?
            "\(self.airDate.toRussianDate().string) (ожидается)" : "\(self.airDate.toRussianDate().string)"
    }
    
    var posterURL: URL? {
        ImageURL.poster(.w185, posterPath).fullURL
    }
    
// MARK: - Init
    init(_ model: TVSeasonModel) {
        self.airDate = model.airDate ?? ""
        self.episodeCount = model.episodeCount
        self.id = "\(model.id)"
        self.name = model.name
        self.overview = model.overview
        self.posterPath = model.posterPath
        self.seasonNumber = "\(model.seasonNumber)"
    }
}

extension TVSeasonCellViewModel: IdentifiableType {
    var identity: String { return id }
}

extension TVSeasonCellViewModel: Equatable {
    static func == (lhs: TVSeasonCellViewModel, rhs: TVSeasonCellViewModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}
