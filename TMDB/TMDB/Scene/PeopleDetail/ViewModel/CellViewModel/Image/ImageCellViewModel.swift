//
//  ImageCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.04.2021.
//

import UIKit
import RxDataSources
import Domain

struct ImageCellViewModel {
    
// MARK: - Properties
    let filePath: String
    private (set) var imageType: ImageType
    
    var imageURL: URL? {
        switch imageType {
        case .backdrop(let size):
            if case .small = size { return ImageURL.backdrop(.w300, filePath).fullURL }
            if case .big = size { return ImageURL.backdrop(.original, filePath).fullURL }
            
        case .poster(let size):
            if case .small = size { return ImageURL.poster(.w185, filePath).fullURL }
            if case .big = size { return ImageURL.poster(.original, filePath).fullURL }
            
        case .profile(let size):
            if case .small = size { return ImageURL.profile(.w185, filePath).fullURL }
            if case .big = size { return ImageURL.profile(.original, filePath).fullURL }
        
        case .still(let size):
            if case .small = size { return ImageURL.still(.w300, filePath).fullURL }
            if case .big = size { return ImageURL.still(.original, filePath).fullURL }
            
        default: break
        }
        return nil
    }
    
// MARK: - Init
    init(_ model: ImageModel, imageType: ImageType) {
        self.filePath = model.filePath
        self.imageType = imageType
    }
}

extension ImageCellViewModel: IdentifiableType {
    var identity: String { return filePath }
}

extension ImageCellViewModel: Equatable {
    static func == (lhs: ImageCellViewModel, rhs: ImageCellViewModel) -> Bool {
        return lhs.filePath == rhs.filePath
    }
}

extension ImageCellViewModel {
    
    mutating func changeImageType(to imageType: ImageType) {
        self.imageType = imageType
    }
}
