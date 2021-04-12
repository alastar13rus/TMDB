//
//  URL+Extensions.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.03.2021.
//

import Foundation

extension URL {
    func downloadImageData(completion: @escaping (Data) -> Void) {
        DispatchQueue.global(qos: .background).async {
            URLSession(configuration: .default).dataTask(with: self) { (data, _, _) in
                
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    completion(data)
                }
            }.resume()
        }
    }
}
