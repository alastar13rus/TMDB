//
//  MovieCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 17.03.2021.
//

import Foundation
import RxDataSources

struct MovieCellViewModel {
    let id: String
    let title: String
    let overview: String
    let voteAverage: CGFloat
    let posterPath: String?
    
    private var posterAbsolutePath: URL? {
        return ImageURL.poster(.w154, posterPath).fullURL
    }
    
    func posterImageData(completion: @escaping (Data) -> Void) {
        guard let url = posterAbsolutePath else { return }
        url.downloadImageData { imageData in
            completion(imageData)
        }
    }
    
    init(_ model: MovieModel) {
        self.id = String(model.id)
        self.title = model.title
        self.overview = model.overview
        self.voteAverage = CGFloat(model.voteAverage * 10)
        self.posterPath = model.posterPath
        
    }
    
    
}

extension MovieCellViewModel: IdentifiableType {
    var identity: String { id }
    
    
}

extension MovieCellViewModel: Hashable {
    
}

extension MovieCellViewModel: Equatable {
    
}
