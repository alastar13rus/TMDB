//
//  NavigationBarAppearance.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 10.04.2021.
//

import UIKit

class NavigationBarAppearance: UINavigationBarAppearance {
    
    override init(barAppearance: UIBarAppearance) {
        super.init(barAppearance: barAppearance)
        
        
        self.configureWithTransparentBackground()
        self.backgroundImageContentMode = .scaleAspectFill
        self.titleTextAttributes = [
            .foregroundColor: UIColor.darkText,
        ]
        self.largeTitleTextAttributes = [
            .foregroundColor: UIColor.lightText,
            .font: UIFont.boldSystemFont(ofSize: 24),
        ]
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
}
