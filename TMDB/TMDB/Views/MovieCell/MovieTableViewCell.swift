//
//  MovieTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.03.2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    var viewModel: MovieCellViewModel! {
        didSet {
            self.configure(with: viewModel)
        }
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
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
    private func configure(with vm: MovieCellViewModel) {
        titleLabel.text = vm.title
        overviewLabel.text = vm.overview
    }
    
    private func setupUI() {
        
    }
    
    private func setupHierarhy() {
        addSubview(titleLabel)
        addSubview(overviewLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -8),
            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            overviewLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            overviewLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -8),
            overviewLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
    
}
