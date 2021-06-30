//
//  MediaTableView.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.04.2021.
//

import UIKit

class MediaListTableView: UITableView {
    
    convenience init(cellType: UITableViewCell.Type, refreshControl: UIRefreshControl) {
        self.init()
        
        self.register(cellType.self, forCellReuseIdentifier: cellType.reuseId)
        self.separatorStyle = .singleLine
        self.separatorColor = .systemBlue
        self.separatorInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        self.tableFooterView = UIView()
        self.refreshControl = refreshControl
        self.showsVerticalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
