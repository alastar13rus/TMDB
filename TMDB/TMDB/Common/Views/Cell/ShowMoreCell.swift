//
//  ShowMoreCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.04.2021.
//

import UIKit

class ShowMoreCell: UICollectionViewCell {
    
//    MARK: - Properties
    let showMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("→", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.tintColor = .systemBlue
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.text = "Показать еще"
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupHierarhy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    MARK: - Methods
    fileprivate func setupUI() {
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 10
    }
    
    fileprivate func setupHierarhy() {
        contentView.addSubview(showMoreButton)
        contentView.addSubview(textLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            showMoreButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            showMoreButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            showMoreButton.widthAnchor.constraint(equalToConstant: 40),
            showMoreButton.heightAnchor.constraint(equalToConstant: 40),
            
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
