//
//  SearchCategoryCollectionViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import UIKit
import RxDataSources

class SearchCategoryCollectionViewCell: UICollectionViewCell {
    
//    MARK: - Properties
    var viewModel: SearchCategoryCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
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
        backgroundColor = .systemGray5
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    fileprivate func setupHierarhy() {
        addSubview(categoryLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            categoryLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            categoryLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            categoryLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
        ])
    }
    
    fileprivate func configure(with vm: SearchCategoryCellViewModel) {
        categoryLabel.text = vm.title
    }
}
