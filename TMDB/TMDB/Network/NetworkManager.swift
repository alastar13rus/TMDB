//
//  NetworkManager.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 15.03.2021.
//

import Foundation

class NetworkManager: NetworkManagerProtocol {
    
    func request<T: Decodable>(_ api: API, completion: @escaping (Result<T, Error>) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            
            var components = URLComponents()
            components.scheme = api.scheme
            components.host = api.host
            components.path = api.path
            components.queryItems = api.parameters
            
            
            guard let url = components.url else { return }

            let request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            
            let dataTask = session.dataTask(with: request) { (data, response, error) in
//                if let data = data {
//                         if let jsonString = String(data: data, encoding: .utf8) {
//                            print(jsonString)
//                         }
//                       }
                guard error == nil else { return }
                guard response != nil else { return }
                guard let data = data else { return }
//                let responseObject = try! JSONDecoder().decode(T.self, from: data)
                do {
                    let responseObject = try JSONDecoder().decode(T.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(.success(responseObject))
                    }
                } catch {
                    return
                }
            }
            
            dataTask.resume()
            
        }
        
        
    }
    
    
}
