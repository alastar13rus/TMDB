//
//  MediaListType.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 28.04.2021.
//

import Foundation

enum MediaListType: String, Decodable {
    case recommendation
    case similar
    
    var title: String {
        switch self {
        case .recommendation:
            return "Рекомендации"
        case .similar:
            return "Похожие"
        }
    }
}
