//
//  AppConfig.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 14.05.2021.
//

import Foundation

final class AppConfig {
    
    var apiKey: String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String
        else { fatalError("ApiKey не установлен") }
        return apiKey
    }
    
    var apiBaseURL: String {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String
        else { fatalError("ApiBaseURL не установлен") }
        return apiBaseURL
    }
    
    var imagesBaseURL: String {
        guard let imagesBaseURL = Bundle.main.object(forInfoDictionaryKey: "ImagesBaseURL") as? String
        else { fatalError("ImagesBaseURL не установлен") }
        return imagesBaseURL
    }
    
}
