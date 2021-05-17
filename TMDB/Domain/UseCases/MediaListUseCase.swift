//
//  MediaListUseCase.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 16.05.2021.
//

import Foundation

protocol MediaListUseCase {
    func fetchMediaList<T: MediaListResponseProtocol>(completion: @escaping (T) -> Void)
    
}
