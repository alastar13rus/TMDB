//
//  CreditInMediaViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 19.04.2021.
//

import Foundation

struct CreditInMediaViewModel {
    
    let id: String
    let mediaTitle: String
    let mediaType: MediaType
    let mediaPosterPath: String?
    let credit: String
    let voteAverage: Float
    
    func mediaPosterImageView(completion: @escaping (Data?) -> Void) {
        guard let posterPath = mediaPosterPath else { completion(nil); return }
        guard let mediaPosterFullURL = ImageURL.poster(.w154, posterPath).fullURL else { completion(nil); return }
        
        mediaPosterFullURL.downloadImageData { (imageData) in
            completion(imageData)
        }
    }
}

extension CreditInMediaViewModel {
    init(_ model: CastInMediaModel) {
        
        self.id = "\(model.id)"
        self.mediaPosterPath = model.posterPath
        self.credit = model.character ?? ""
        self.voteAverage = model.voteAverage
        self.mediaType = model.mediaType
        
        switch model.mediaType {
        case .movie: self.mediaTitle = model.title!
        case .tv: self.mediaTitle = model.name!
        }
    }
}

extension CreditInMediaViewModel {
    init(_ model: CrewInMediaModel) {
        
        self.id = "\(model.id)"
        self.mediaPosterPath = model.posterPath
        self.credit = model.job
        self.voteAverage = model.voteAverage
        self.mediaType = model.mediaType
        
        switch model.mediaType {
        case .movie: self.mediaTitle = model.title!
        case .tv: self.mediaTitle = model.name!
        }
    }
}

extension CreditInMediaViewModel {
    init(_ model: GroupedCreditInMediaModel) {
        
        self.id = "\(model.id)"
        self.mediaPosterPath = model.posterPath
        self.credit = model.credit
        self.voteAverage = model.voteAverage
        self.mediaType = model.mediaType
         
        if !model.releaseYear.isEmpty {
            self.mediaTitle = "\(model.mediaTitle) (\(model.releaseYear))"
        } else {
            self.mediaTitle = model.mediaTitle
        }
    }
}
