//
//  PeopleImageCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.04.2021.
//

import UIKit
import RxDataSources

class PeopleImageCellViewModel {
    
//    MARK: - Properties
    let filePath: String
    
    
//    MARK: - Init
    init(_ model: PeopleImageList.ImageModel) {
        self.filePath = model.filePath
    }
    
    
    
//    MARK: - Methods
    func profileImageData(completion: @escaping (Data?) -> Void) {
        guard let imageFullURL = ImageURL.profile(.w185, filePath).fullURL else {
            completion(nil); return
        }
        imageFullURL.downloadImageData { (data) in
            guard let imageData = data else { completion(nil); return }
            completion(imageData)
        }
        
    }
}

extension PeopleImageCellViewModel: IdentifiableType {
    var identity: String { return filePath }
}


extension PeopleImageCellViewModel: Equatable {
    static func == (lhs: PeopleImageCellViewModel, rhs: PeopleImageCellViewModel) -> Bool {
        return lhs.filePath == rhs.filePath
    }
    
    
}
