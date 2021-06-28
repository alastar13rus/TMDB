//
//  UIImageView+Extension.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 24.06.2021.
//
import UIKit
import Domain
import CachePlatform

extension UIImageView {
    
    func loadImage(with url: URL?, placeholder: UIImage? = nil, _ completion: ((UIImage?) -> Void)? = nil) {
        
        let cache = CachePlatform.CacheProvider.shared
        let urlSession = URLSession.shared
        
        self.image = placeholder
        DispatchQueue.global(qos: .background).async {
            
            guard let url = url else {
                DispatchQueue.main.async { completion?(nil) }
                return
            }
            
            guard let image = cache[url] else {
                
                let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
                    
                    guard error == nil, let data = data, let image = UIImage(data: data) else {
                        DispatchQueue.main.async { completion?(nil) }
                        return
                    }
                    
                    cache[url] = image
                    DispatchQueue.main.async { completion?(image) }
                    
                }
                
                dataTask.resume()
                return
            }
            DispatchQueue.main.async { completion?(image) }
            
        }
    }
}
