//
//  PeopleCollectionViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import UIKit

class PeopleCollectionViewCell: UICollectionViewCell {
    
//    MARK: - Properties
    var viewModel: PeopleCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
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
    fileprivate func setupUI() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    fileprivate func setupHierarhy() {
        addSubview(activityIndicatorView)
        addSubview(profileImageView)
        addSubview(nameLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            
            activityIndicatorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            activityIndicatorView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            activityIndicatorView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            profileImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            profileImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 4 / 3),
            
            nameLabel.leftAnchor.constraint(equalTo: profileImageView.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: profileImageView.rightAnchor),
            nameLabel.bottomAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
        ])
    }
    
    fileprivate func configure(with vm: PeopleCellViewModel) {
        nameLabel.text = vm.name
        
        vm.profileImageData { [weak self] (data) in
            
            vm.profileImageData { [weak self] (imageData) in
                guard let self = self else { return }
                self.activityIndicatorView.stopAnimating()
                
                if imageData == nil {
                    self.profileImageView.contentMode = .scaleAspectFit
                    self.profileImageView.image = #imageLiteral(resourceName: "unknownGenderPlaceholder").withTintColor(.systemGray4, renderingMode: .alwaysOriginal)
                } else {
                    self.profileImageView.contentMode = .scaleAspectFill
                    self.profileImageView.image = UIImage(data: imageData!)
                }
            }
        }
    }
}
