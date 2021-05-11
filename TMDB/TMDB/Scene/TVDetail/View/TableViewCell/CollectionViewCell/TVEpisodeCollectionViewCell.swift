//
//  TVEpisodeCollectionViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.05.2021.
//

import UIKit

class TVEpisodeCollectionViewCell: UICollectionViewCell {
    
//    MARK: - Properties
    
    var viewModel: TVEpisodeCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let stillImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let episodeNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
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
    
    
    
    
//    MARK: - Methods
    
    fileprivate func configure(with vm: TVEpisodeCellViewModel) {
        nameLabel.text = vm.name
        episodeNumberLabel.text = "Эпизод \(vm.episodeNumber)"

        vm.stillImageData { [weak self] imageData in
            guard let self = self else { return }
            self.activityIndicatorView.stopAnimating()
            
            guard let imageData = imageData else {
                self.stillImageView.contentMode = .scaleAspectFit
                self.stillImageView.image = #imageLiteral(resourceName: "mediaPlaceholder").withTintColor(.systemGray4, renderingMode: .alwaysOriginal)
                return
            }
            
            self.stillImageView.contentMode = .scaleAspectFill
            self.stillImageView.image = UIImage(data: imageData)
        }
    }
    
    fileprivate func setupUI() {
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemGray6
        
    }
    
    fileprivate func setupHierarhy() {
        addSubview(activityIndicatorView)
        addSubview(stillImageView)
        addSubview(episodeNumberLabel)
        addSubview(nameLabel)
    }
    
    fileprivate func setupConstraints() {
            NSLayoutConstraint.activate([
                
                activityIndicatorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                activityIndicatorView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
                activityIndicatorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                activityIndicatorView.widthAnchor.constraint(equalTo: activityIndicatorView.heightAnchor),
                
                stillImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                stillImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
                stillImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                stillImageView.widthAnchor.constraint(equalTo: stillImageView.heightAnchor),
                
                episodeNumberLabel.topAnchor.constraint(equalTo: stillImageView.topAnchor),
                episodeNumberLabel.leftAnchor.constraint(equalTo: stillImageView.rightAnchor, constant: 12),
                episodeNumberLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
                
                nameLabel.topAnchor.constraint(greaterThanOrEqualTo: episodeNumberLabel.bottomAnchor),
                nameLabel.leftAnchor.constraint(equalTo: episodeNumberLabel.leftAnchor),
                nameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
                nameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            ])
    }
    
    
}
