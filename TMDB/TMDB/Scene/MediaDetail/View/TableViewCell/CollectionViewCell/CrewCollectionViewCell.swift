//
//  CrewCollectionViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 13.04.2021.
//

import UIKit

class CrewCollectionViewCell: UICollectionViewCell {
    
//    MARK: - Properties
    var viewModel: CrewCellViewModel! {
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
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
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
    fileprivate func configure(with vm: CrewCellViewModel) {
        nameLabel.text = vm.name
        jobLabel.text = vm.job
        
        vm.profileImageData { [weak self] (data) in
            
            vm.profileImageData { [weak self] (imageData) in
                guard let self = self else { return }
                self.activityIndicatorView.stopAnimating()
                
                if imageData == nil {
                    self.profileImageView.contentMode = .scaleAspectFit
                    self.profileImageView.image = GenderFactory.buildImage(withGender: vm.gender)
                } else {
                    self.profileImageView.contentMode = .scaleAspectFill
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
        addSubview(jobLabel)

    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            
            activityIndicatorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            activityIndicatorView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            activityIndicatorView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            profileImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.8),
            profileImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            profileImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            jobLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            jobLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            jobLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            jobLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
    
}
