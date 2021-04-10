//
//  TVInfoCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 10.04.2021.
//

import UIKit

class TVInfoCell: UITableViewCell {
    
//    MARK: - Properties
    var viewModel: TVInfoCellViewModel! {
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
    
    let genresLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let creatorsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusLabel: UILabel = {
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
    fileprivate func configureCell(with vm: TVInfoCellViewModel) {
        runtimeLabel.text = vm.runtime
        genresLabel.text = vm.genres
        creatorsLabel.text = vm.creators
        statusLabel.text = vm.status
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        addSubview(runtimeLabel)
        addSubview(genresLabel)
        addSubview(creatorsLabel)
        addSubview(statusLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            runtimeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            runtimeLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            runtimeLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
            
            genresLabel.topAnchor.constraint(equalTo: runtimeLabel.bottomAnchor, constant: 12),
            genresLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            genresLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
            
            creatorsLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: 12),
            creatorsLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            creatorsLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
            
            statusLabel.topAnchor.constraint(equalTo: creatorsLabel.bottomAnchor, constant: 12),
            statusLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            statusLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
            statusLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
        ])
    }
}
