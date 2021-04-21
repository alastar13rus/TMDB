//
//  PeopleBioCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.04.2021.
//

import UIKit

class PeopleBioCell: UITableViewCell {
    
    //    MARK: - Properties
    var viewModel: PeopleBioCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let bioLabel: UILabel = {
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
    fileprivate func configure(with vm: PeopleBioCellViewModel) {
        bioLabel.text = vm.bio
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        addSubview(bioLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            bioLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            bioLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            bioLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
        ])
    }
    
}
