//
//  RefreshControl.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.04.2021.
//

import UIKit

class RefreshControl: UIRefreshControl {
    
    convenience init(action: Selector) {
        self.init()
        
        self.endRefreshing()
        self.addTarget(self, action: action, for: .valueChanged)
    }

}
