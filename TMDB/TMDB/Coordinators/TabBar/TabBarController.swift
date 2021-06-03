//
//  TabBarControllerDelegate.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.04.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    weak var coordinator: TabBarCoordinator?
    
}

extension TabBarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0: coordinator?.showMovieTab()
        case 1: coordinator?.showTVTab()
        case 2: coordinator?.showSearchTab()
//        case 2: coordinator?.showFavoriteTab()
        default: break
        }
    }
}
