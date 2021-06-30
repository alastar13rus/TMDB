//
//  ShowMoreCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.04.2021.
//

import UIKit

class ShowMoreCell: UICollectionViewCell {
    
// MARK: - Properties
    var viewModel: ShowMoreCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let showMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.isUserInteractionEnabled = false
        button.setTitle("→", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.tintColor = .systemBlue
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let showMoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.text = "Показать еще"
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupHierarhy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Methods
    fileprivate func configure(with vm: ShowMoreCellViewModel) {
        showMoreLabel.text = vm.title
    }
    
    fileprivate func setupUI() {
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 10
    }
    
    fileprivate func setupHierarhy() {
        contentView.addSubview(showMoreButton)
        contentView.addSubview(showMoreLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            showMoreButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            showMoreButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            showMoreButton.widthAnchor.constraint(equalToConstant: 60),
            showMoreButton.heightAnchor.constraint(equalToConstant: 60),
            
            showMoreLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            showMoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
