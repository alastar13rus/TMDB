//
//  TabBarDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 05.04.2021.
//

import UIKit

class TabBarControllerDataSource {
    
// MARK: - Properties
    private(set) var items: [UINavigationController]
    
// MARK: - Init
    init() {
        self.items = Array(0...3).map { _ -> UINavigationController in
            let navigation = UINavigationController()
            navigation.navigationBar.prefersLargeTitles = true
            navigation.navigationItem.largeTitleDisplayMode = .always
            navigation.view.backgroundColor = .white
            return navigation
        }
        self.items[0].tabBarItem = .init(title: "Фильмы", image: #imageLiteral(resourceName: "movieTab"), tag: 0)
        self.items[1].tabBarItem = .init(title: "Сериалы", image: #imageLiteral(resourceName: "tvTab"), tag: 1)
        self.items[2].tabBarItem = .init(title: "Поиск", image: #imageLiteral(resourceName: "searchTab"), tag: 2)
        self.items[3].tabBarItem = .init(title: "Избранное", image: #imageLiteral(resourceName: "favoriteTab"), tag: 3)
        
    }
    
// MARK: - Methods
//    func setItems(_ newValue: [UINavigationController]) {
//        self.items = newValue
//    }
}
