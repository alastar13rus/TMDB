//
//  GenresCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 10.04.2021.
//

import UIKit

class GenresCell: UITableViewCell {
    
    //    MARK: - Properties
        var viewModel: GenresCellViewModel! {
            didSet {
                configureCell(with: viewModel)
            }
        }
    
        let genresLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
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
        fileprivate func configureCell(with vm: GenresCellViewModel) {
            genresLabel.text = vm.genres
        }
        
        fileprivate func setupUI() {
            
        }
        
        fileprivate func setupHierarhy() {
            addSubview(genresLabel)
        }
        
        fileprivate func setupConstraints() {
            NSLayoutConstraint.activate([
                genresLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
                genresLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
                genresLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
                genresLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            ])
        }
    }
