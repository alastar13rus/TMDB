//
//  TVEpisodeCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 05.05.2021.
//

import Foundation
import RxDataSources

struct TVEpisodeCellViewModel {
    
//    MARK: - Properties
    let airDate: String
    let episodeNumber: String
    let id: String
    let name: String
    let overview: String
    let seasonNumber: String
    let stillPath: String?
    let voteAverage: Float
    let voteCount: Int
    
    var airDateText: String {
        guard let airDate = airDate.toRussianDate().date else { return "" }
        return (airDate > Date()) ?
            "\(self.airDate.toRussianDate().string) (ожидается)" : "\(self.airDate.toRussianDate().string)"
    }
    
    func stillImageData(completion: @escaping (Data?) -> Void) {
        guard let stillPath = stillPath else { completion(nil); return }
        guard let stillAbsoluteURL = ImageURL.still(.w300, stillPath).fullURL else { completion(nil); return }
        
        stillAbsoluteURL.downloadImageData { (imageData) in
            completion(imageData)
        }
    }
    
//    MARK: - Init
    init(_ model: TVEpisodeDetailModel) {
        self.airDate = model.airDate ?? ""
        self.id = "\(model.id)"
        self.name = model.name
        self.overview = model.overview
        self.stillPath = model.stillPath
        self.episodeNumber = "\(model.episodeNumber)"
        self.seasonNumber = "\(model.seasonNumber)"
        self.voteAverage = model.voteAverage
        self.voteCount = model.voteCount
    }
}

extension TVEpisodeCellViewModel: IdentifiableType {
    var identity: String { return id }
}


extension TVEpisodeCellViewModel: Equatable {
    static func ==(lhs: TVEpisodeCellViewModel, rhs: TVEpisodeCellViewModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}
