//
//  TVEpisodeStillWrapperCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.05.2021.
//

import Foundation

struct TVEpisodeStillWrapperCellViewModel {
    
//    MARK: - Properties
    let airDate: String
    let name: String
    let overview: String
    let id: String
    let stillPath: String?
    let episodeNumber: String
    
    var airYear: String { "\(airDate.prefix(4))" }
    
    func stillImageData(completion: @escaping (Data?) -> Void) {
        guard let stillPath = stillPath else { completion(nil); return }
        guard let stillAbsoluteURL = ImageURL.still(.original, stillPath).fullURL else { completion(nil); return }
        
        stillAbsoluteURL.downloadImageData { (imageData) in
            completion(imageData)
        }
    }
    
    
//    MARK: - Init
    init(_ model: TVEpisodeDetailModel) {
        self.airDate = model.airDate ?? ""
        self.name = model.name
        self.overview = model.overview
        self.id = "\(model.id)"
        self.stillPath = model.stillPath
        self.episodeNumber = "\(model.episodeNumber)"
    }
}
