//
//  ImageType.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 28.04.2021.
//

import Foundation

public enum ImageType {
    case backdrop(size: Size)
    case logo(size: Size)
    case poster(size: Size)
    case profile(size: Size)
    case still(size: Size)
    
    public enum Size {
        case small
        case big
    }
}
