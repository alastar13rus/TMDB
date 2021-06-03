//
//  FilterOptionMediaByYearTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.05.2021.
//

import UIKit

class FilterOptionMediaByYearTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    var viewModel: FilterOptionMediaByYearCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupHierarhy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Methods
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        addSubview(titleLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            titleLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    fileprivate func configure(with vm: FilterOptionMediaByYearCellViewModel) {
        titleLabel.text = vm.title
    }
    
}
