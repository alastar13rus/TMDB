//
//  TVCreatorsCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 10.04.2021.
//

import UIKit

class TVCreatorsCell: UITableViewCell {
    
//    MARK: - Properties
    var viewModel: TVCreatorsCellViewModel! {
        didSet {
            configureCell(with: viewModel)
        }
    }
    
    let creatorsLabel: UILabel = {
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
    fileprivate func configureCell(with vm: TVCreatorsCellViewModel) {
        creatorsLabel.text = vm.creators
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        addSubview(creatorsLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            creatorsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            creatorsLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            creatorsLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
            creatorsLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
        ])
    }
}
