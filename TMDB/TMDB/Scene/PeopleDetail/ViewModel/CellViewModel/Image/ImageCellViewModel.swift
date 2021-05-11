//
//  ImageCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.04.2021.
//

import UIKit
import RxDataSources

struct ImageCellViewModel {
    
//    MARK: - Properties
    let filePath: String
    private (set) var imageType: ImageType
    
    
//    MARK: - Init
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
    
    func imageData(completion: @escaping (Data?) -> Void) {
        var imageFullURL: URL?
        switch imageType {
        case .profile(let size):
            switch size {
            case .small:
                guard let fullURL = ImageURL.profile(.w185, filePath).fullURL else {
                    completion(nil); return
                }
                imageFullURL = fullURL
            default:
                guard let fullURL = ImageURL.profile(.original, filePath).fullURL else {
                    completion(nil); return
                }
                imageFullURL = fullURL
            }
            
        case .poster(let size):
            switch size {
            case .small:
                guard let fullURL = ImageURL.poster(.w185, filePath).fullURL else {
                    completion(nil); return
                }
                imageFullURL = fullURL
            default:
                guard let fullURL = ImageURL.poster(.original, filePath).fullURL else {
                    completion(nil); return
                }
                imageFullURL = fullURL
            }
            
        case .backdrop(let size):
            switch size {
            case .small:
                guard let fullURL = ImageURL.backdrop(.w300, filePath).fullURL else {
                    completion(nil); return
                }
                imageFullURL = fullURL
            default:
                guard let fullURL = ImageURL.backdrop(.original, filePath).fullURL else {
                    completion(nil); return
                }
                imageFullURL = fullURL
            }
        
        case .still(let size):
            switch size {
            case .small:
                guard let fullURL = ImageURL.still(.w300, filePath).fullURL else {
                    completion(nil); return
                }
                imageFullURL = fullURL
            default:
                guard let fullURL = ImageURL.still(.original, filePath).fullURL else {
                    completion(nil); return
                }
                imageFullURL = fullURL
            }
        default: break
        }
        
        imageFullURL?.downloadImageData { (data) in
            guard let imageData = data else { completion(nil); return }
            completion(imageData)
        }
    }
}
