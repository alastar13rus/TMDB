//
//  TVSeasonShortListSectionHeaderView.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 03.05.2021.
//

import UIKit

class TVSeasonShortListSectionHeaderView: UIView {
    
// MARK: - Properties
    var title = ""
    var numberOfSeasons = 0
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var showTVSeasonListButtonPressed: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemOrange, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
// MARK: - Init
    convenience init(title: String, numberOfSeasons: Int) {
        self.init()
        self.title = title
        self.numberOfSeasons = numberOfSeasons
        
        configure()
        setupUI()
        setupHierarhy()
        setupConstraints()
    }
    
// MARK: - Methods
    fileprivate func configure() {
        titleLabel.text = title
        showTVSeasonListButtonPressed.setTitle("\(numberOfSeasons) >", for: .normal)
    }
    
    fileprivate func setupUI() {
        backgroundColor = .systemGray5
        
    }
    
    fileprivate func setupHierarhy() {
        addSubview(titleLabel)
        addSubview(showTVSeasonListButtonPressed)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),

            showTVSeasonListButtonPressed.centerYAnchor.constraint(equalTo: centerYAnchor),
            showTVSeasonListButtonPressed.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            showTVSeasonListButtonPressed.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 12)
        ])
    }
    
}
