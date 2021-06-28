//
//  ReusableHeaderView.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.04.2021.
//

import UIKit

class ReusableHeaderView: UICollectionReusableView {
    
//    MARK: - Properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
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
    func configure(withTitle title: String) {
        titleLabel.text = title
    }
    
    fileprivate func setupUI() {
        backgroundColor = .systemGray5
    }
    
    fileprivate func setupHierarhy() {
        addSubview(titleLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
}
