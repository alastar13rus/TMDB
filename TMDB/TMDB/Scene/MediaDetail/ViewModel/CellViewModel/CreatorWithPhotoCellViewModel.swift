//
//  CreatorWithPhotoCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 10.04.2021.
//

import Foundation

struct CreatorWithPhotoCellViewModel {
    
//    MARK: - Properties
    let id: String
    let name: String
    let profilePath: String?
    
//    MARK: - Init
    init(_ model: CreatorModel) {
        self.id = String(model.id)
        self.name = model.name
        self.profilePath = model.profilePath
    }
    
//    MARK: - Methods
    func profileImageData(completion: @escaping (Data?) -> Void) {
        guard let profilePath = profilePath else {
            completion(nil)
            return
        }
        
        let profileAbsolutePath = ImageURL.profile(.w185, profilePath).fullURL
        guard let path = profileAbsolutePath else {
            completion(nil)
            return
        }
        path.downloadImageData(completion: { (data) in
            completion(data)
        })
    }
}
