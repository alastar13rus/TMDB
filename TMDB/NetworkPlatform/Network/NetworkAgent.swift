//
//  NetworkAgent.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 17.05.2021.
//

import Foundation
import Domain

public final class NetworkAgent {
    
    typealias Endpoint = Domain.Endpoint
    
    public init() { }
    
    func getItem<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            
            var components = URLComponents()
            components.scheme = "https"
            components.host = endpoint.host
            components.path = endpoint.path
            components.queryItems = endpoint.queryItems
            
            
            guard let url = components.url else { return }
//            print(url)
            let request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                
                guard error == nil else { return }
                guard response != nil else { return }
                guard let data = data else { return }
                
//  FIXME: - оставил пока, пусть крашится
                _ = try! JSONDecoder().decode(T.self, from: data)
                
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
