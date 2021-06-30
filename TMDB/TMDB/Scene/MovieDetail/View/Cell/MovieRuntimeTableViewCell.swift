//
//  MovieRuntimeTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.04.2021.
//

import UIKit

class MovieRuntimeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
        var viewModel: MovieRuntimeCellViewModel! {
            didSet {
                configureCell(with: viewModel)
            }
        }
        
        let runtimeLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
    // MARK: - Init
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            setupUI()
            setupHierarhy()
            setupConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        
        selectionStyle = .none
    }
        
    // MARK: - Methods
        fileprivate func configureCell(with vm: MovieRuntimeCellViewModel) {
            runtimeLabel.text = vm.runtimeText
        }
        
        fileprivate func setupUI() {
            
        }
        
        fileprivate func setupHierarhy() {
            addSubview(runtimeLabel)
        }
        
        fileprivate func setupConstraints() {
            NSLayoutConstraint.activate([
                runtimeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
                runtimeLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
                runtimeLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
                runtimeLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12)
            ])
        }
    }
