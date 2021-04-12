//
//  TVCreatorWithPhotoCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 10.04.2021.
//

import UIKit

class TVCreatorWithPhotoCell: UITableViewCell {
    
//    MARK: - Properties
    var viewModel: TVCreatorWithPhotoCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
    fileprivate func configure(with vm: TVCreatorWithPhotoCellViewModel) {
        nameLabel.text = vm.name
        
        vm.profileImageData { [weak self] (imageData) in
            
            if imageData == nil {
                self?.profileImageView.image = #imageLiteral(resourceName: "man").withTintColor(.systemGray4, renderingMode: .alwaysOriginal)
            } else {
                self?.profileImageView.image = UIImage(data: imageData!)
            }
        }
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        addSubview(profileImageView)
        addSubview(nameLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            profileImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            profileImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            profileImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.66),
            
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12),
            nameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
            nameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
        ])
    }

    
}
