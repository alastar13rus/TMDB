//
//  TVDetailTableView.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 09.04.2021.
//

import UIKit

class TVDetailTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.separatorColor = .clear
//        self.allowsSelection = false
        self.tableFooterView = UIView()
        self.showsVerticalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
