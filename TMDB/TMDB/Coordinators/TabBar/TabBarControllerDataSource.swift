//
//  TabBarDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 05.04.2021.
//

import UIKit

class TabBarControllerDataSource {
    let items = [
        UINavigationController(),
        UINavigationController(),
        UINavigationController(),
    ]
    
    init() {
        self.items[0].tabBarItem = .init(title: "Фильмы", image: #imageLiteral(resourceName: "movieTab"), tag: 0)
        
        self.items[1].navigationBar.prefersLargeTitles = true
        self.items[1].navigationItem.largeTitleDisplayMode = .always
        self.items[1].tabBarItem = .init(title: "Сериалы", image: #imageLiteral(resourceName: "tvTab"), tag: 1)
        
        self.items[2].tabBarItem = .init(title: "Избранное", image: #imageLiteral(resourceName: "favoriteTab"), tag: 2)
    }
}
