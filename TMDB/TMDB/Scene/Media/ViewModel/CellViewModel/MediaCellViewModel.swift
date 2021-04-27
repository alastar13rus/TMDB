//
//  MediaCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 17.03.2021.
//

import Foundation
import RxDataSources

class MediaCellViewModel {
    
    var id: String = ""
    var title: String = ""
    var mediaType: MediaType = .movie
    var overview: String = ""
    var voteAverage: CGFloat = 0.0
    var posterPath: String? = nil
    
    func posterImageData(completion: @escaping (Data?) -> Void) {
        guard let posterPath = posterPath else { completion(nil); return }
        guard let posterAbsoluteURL = ImageURL.poster(.w154, posterPath).fullURL else { completion(nil); return }
        
        posterAbsoluteURL.downloadImageData { (imageData) in
            completion(imageData)
        }
    }
}

extension MediaCellViewModel: IdentifiableType {
    var identity: String { id }
}

extension MediaCellViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension MediaCellViewModel: Equatable {
    static func ==(lhs: MediaCellViewModel, rhs: MediaCellViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension MediaCellViewModel {
    
    
    convenience init(movieModel model: MovieModel) {
        self.init()
        self.id = String(model.id)
        self.title = model.title
        self.mediaType = .movie
        self.overview = model.overview
        self.voteAverage = CGFloat(model.voteAverage * 10)
        self.posterPath = model.posterPath
        
    }
}

extension MediaCellViewModel {
    
    
    convenience init(tvModel model: TVModel) {
        self.init()
        self.id = String(model.id)
        self.title = model.name
        self.mediaType = .tv
        self.overview = model.overview
        self.voteAverage = CGFloat(model.voteAverage * 10)
        self.posterPath = model.posterPath
        
    }
}

extension MediaCellViewModel {
    
    
    convenience init<T: MediaProtocol>(_ model: T) {
        self.init()
        if model is MovieModel { self.init(movieModel: model as! MovieModel) }
        if model is TVModel { self.init(tvModel: model as! TVModel) }
    }
}
