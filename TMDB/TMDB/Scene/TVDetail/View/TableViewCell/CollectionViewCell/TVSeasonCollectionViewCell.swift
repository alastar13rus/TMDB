//
//  TVSeasonCollectionViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 01.05.2021.
//

import UIKit

class TVSeasonCollectionViewCell: UICollectionViewCell {
    
//    MARK: - Properties
    
    var viewModel: TVSeasonCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let episodeCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
    
    fileprivate func configure(with vm: TVSeasonCellViewModel) {
        nameLabel.text = vm.name
        episodeCountLabel.text = "\(vm.episodeCountText)"
                
        vm.posterImageData { [weak self] imageData in
            guard let self = self else { return }
            self.activityIndicatorView.stopAnimating()
            
            guard let imageData = imageData else {
                self.posterImageView.contentMode = .scaleAspectFit
                self.posterImageView.image = #imageLiteral(resourceName: "mediaPlaceholder").withTintColor(.systemGray4, renderingMode: .alwaysOriginal)
                return
            }
            
            self.posterImageView.contentMode = .scaleAspectFill
            self.posterImageView.image = UIImage(data: imageData)
        }
    }
    
    fileprivate func setupUI() {
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemGray6
        
    }
    
    fileprivate func setupHierarhy() {
        addSubview(activityIndicatorView)
        addSubview(posterImageView)
        addSubview(nameLabel)
        addSubview(episodeCountLabel)
    }
    
    fileprivate func setupConstraints() {
            NSLayoutConstraint.activate([
                
                activityIndicatorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                activityIndicatorView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
                activityIndicatorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                activityIndicatorView.widthAnchor.constraint(equalTo: activityIndicatorView.heightAnchor),
                
                posterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                posterImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
                posterImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor),

                nameLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
                nameLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 12),
                nameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
                
                episodeCountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
                episodeCountLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
                episodeCountLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            ])
    }
    
    
}
