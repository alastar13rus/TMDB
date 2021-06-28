//
//  CacheProvider.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 23.06.2021.
//

import UIKit

public protocol CacheProvider {
    
    func image(for url: URL) -> UIImage?
    func saveImage(_ image: UIImage?, url: URL)
    func removeImage(for url: URL)

}
