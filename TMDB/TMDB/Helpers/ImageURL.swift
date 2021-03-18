//
//  ImageURL.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.03.2021.
//

import Foundation

enum ImageURL {
    case backdrop(BackdropSize, String?)
    case logo(LogoSize, String?)
    case poster(PosterSize, String?)
    case profile(ProfileSize, String?)
    case still(StillSize, String?)
    
    var secureBaseUrlImagePrefix: String {
        return "https://image.tmdb.org/t/p/"
    }
    
    var fullURL: URL? {
        
        switch self {
        case .backdrop(let size, let imagePath):
            return URL(string: secureBaseUrlImagePrefix + size.rawValue + imagePath!)
        case .logo(let size, let imagePath):
            return URL(string: secureBaseUrlImagePrefix + size.rawValue + imagePath!)
        case .poster(let size, let imagePath):
            return URL(string: secureBaseUrlImagePrefix + size.rawValue + imagePath!)
        case .profile(let size, let imagePath):
            return URL(string: secureBaseUrlImagePrefix + size.rawValue + imagePath!)
        case .still(let size, let imagePath):
            return URL(string: secureBaseUrlImagePrefix + size.rawValue + imagePath!)
        }
    }
}

enum BackdropSize: String {
    case w300
    case w780
    case w1280
    case original
}

enum LogoSize: String {
    case w45
    case w92
    case w154
    case w185
    case w300
    case w500
    case original
}

enum PosterSize: String {
    case w92
    case w154
    case w185
    case w342
    case w500
    case w780
    case original
}

enum ProfileSize: String {
    case w45
    case w185
    case h632
    case original
}

enum StillSize: String {
    case w92
    case w185
    case w300
    case original
}
