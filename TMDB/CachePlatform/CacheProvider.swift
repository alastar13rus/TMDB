//
//  CacheProvider.swift
//  CachePlatform
//
//  Created by Докин Андрей (IOS) on 23.06.2021.
//

import UIKit
import Domain

public class CacheProvider: Domain.CacheProvider {
    
    //    MARK: - Properties
    public static let shared = CacheProvider()
    let cache = NSCache<NSString, UIImage>()
    let lock = NSLock()
    
    //    MARK: - Init
    public init() { }
    
//    MARK: - Subscripts
    public subscript(_ url: URL) -> UIImage? {
        get {
            image(for: url)
        }
        
        set {
            saveImage(newValue, url: url)
        }
    }
    
    //    MARK: - Methods
    
    public func image(for url: URL) -> UIImage? {
        lock.lock()
        defer { lock.unlock() }
        guard let image = cache.object(forKey: url.absoluteString as NSString) else { return nil }
        print("\nПолучение из кэша. \n\tКлюч:\t\(url)\n")
        return image
    }
    
    public func saveImage(_ image: UIImage?, url: URL) {
        guard let image = image else { return removeImage(for: url) }
        lock.lock()
        defer { lock.unlock() }
        cache.setObject(image, forKey: url.absoluteString as NSString)
    }
    
    public func removeImage(for url: URL) {
        lock.lock()
        defer { lock.unlock() }
        cache.removeObject(forKey: url.absoluteString as NSString)
    }
    
    
    
    
}
