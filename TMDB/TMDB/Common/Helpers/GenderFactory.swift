//
//  GenderFactory.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 26.04.2021.
//

import UIKit

class GenderFactory {
    
    final class func buildImage(withGender gender: Int) -> UIImage {
        return #imageLiteral(resourceName: "unknownGenderPlaceholder").withTintColor(.systemGray4, renderingMode: .alwaysOriginal)
//        switch gender {
//        case 1:
//            return #imageLiteral(resourceName: "womanPlaceholder").withTintColor(.systemGray4, renderingMode: .alwaysOriginal)
//        case 2:
//            return #imageLiteral(resourceName: "menPlaceholder").withTintColor(.systemGray4, renderingMode: .alwaysOriginal)
//        default:
//            return #imageLiteral(resourceName: "unknownGenderPlaceholder").withTintColor(.systemGray4, renderingMode: .alwaysOriginal)
//        }
    }
    
}
