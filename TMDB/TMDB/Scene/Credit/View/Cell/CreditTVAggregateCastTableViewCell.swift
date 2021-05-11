//
//  CreditTVAggregateCastTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import UIKit

class CreditTVAggregateCastTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    
    var viewModel: AggregateCastCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let characterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalEpisodeCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray3
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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    fileprivate func configure(with vm: AggregateCastCellViewModel) {
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
        
        nameLabel.text = vm.name
        characterLabel.text = vm.roles
        totalEpisodeCountLabel.text = vm.totalEpisodeCountText
        
        
    }
    
    fileprivate func setupUI() {
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
    }
    
    fileprivate func setupHierarhy() {
        addSubview(activityIndicatorView)
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(characterLabel)
        addSubview(totalEpisodeCountLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            activityIndicatorView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            activityIndicatorView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            profileImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            profileImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12),
            nameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
            
            characterLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            characterLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            characterLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            totalEpisodeCountLabel.topAnchor.constraint(equalTo: characterLabel.bottomAnchor, constant: 12),
            totalEpisodeCountLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            totalEpisodeCountLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    
}
