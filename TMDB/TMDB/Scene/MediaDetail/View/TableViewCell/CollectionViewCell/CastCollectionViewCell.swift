//
//  CastCollectionViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
//    MARK: - Properties
    var viewModel: CastCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    var indexPath: IndexPath!
    
    let profileImageView = ProfileImageView()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let characterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupHierarhy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        profileImageView.contentMode = .scaleAspectFill
    }
    
    
//    MARK: - Methods
    fileprivate func configure(with vm: CastCellViewModel) {
        nameLabel.text = vm.name
        characterLabel.text = vm.character
        
        let placeholder = #imageLiteral(resourceName: "unknownGenderPlaceholder").withTintColor(.systemGray5, renderingMode: .alwaysOriginal)
        profileImageView.loadImage(with: vm.profileURL) { [weak self] (image) in
            guard let self = self, self.tag == self.indexPath.row else { return }
            
            guard let image = image else {
                self.profileImageView.image = placeholder
                self.profileImageView.contentMode = .scaleAspectFit
                return
            }
            return self.profileImageView.image = image
        }
    }
    
    fileprivate func setupUI() {
        backgroundColor = .white
    }
    
    fileprivate func setupHierarhy() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(characterLabel)
        
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            profileImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.8),
            profileImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            profileImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),

            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),

            characterLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            characterLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            characterLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            characterLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
    
}
