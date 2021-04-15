//
//  CastCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import UIKit

class CastCell: UICollectionViewCell {
    
//    MARK: - Properties
    var viewModel: CastCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.startAnimating()
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
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
    }
    
    
//    MARK: - Methods
    fileprivate func configure(with vm: CastCellViewModel) {
        nameLabel.text = vm.name
        characterLabel.text = vm.character
        
        self.profileImageView.layer.opacity = 0
        UIView.animate(withDuration: 1.0) {
            self.profileImageView.layer.opacity = 1
            vm.profileImageData { [weak self] (imageData) in
                guard let self = self else { return }
                self.activityIndicatorView.stopAnimating()
                
                if imageData == nil {
                    self.profileImageView.image = #imageLiteral(resourceName: "man").withTintColor(.systemGray4, renderingMode: .alwaysOriginal)
                } else {
                    self.profileImageView.image = UIImage(data: imageData!)
                }
            }
        }
        
    }
    
    fileprivate func setupUI() {
        backgroundColor = .white
    }
    
    fileprivate func setupHierarhy() {
        addSubview(activityIndicatorView)
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(characterLabel)
        
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            
            activityIndicatorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            activityIndicatorView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            activityIndicatorView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
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