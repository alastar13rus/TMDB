//
//  MediaOverviewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 09.04.2021.
//

import UIKit

class MediaOverviewCell: UITableViewCell {
    
//    MARK: - Properties
    var viewModel: MediaOverviewCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
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
    fileprivate func configure(with vm: MediaOverviewCellViewModel) {
        overviewLabel.text = vm.overview
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        addSubview(overviewLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            overviewLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            overviewLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            overviewLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
        ])
    }
    
}
