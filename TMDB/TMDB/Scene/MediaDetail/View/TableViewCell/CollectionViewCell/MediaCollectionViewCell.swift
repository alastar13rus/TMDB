//
//  MediaCollectionViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 27.04.2021.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell {
    
//    MARK: - Properties
    var viewModel: MediaCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let mediaTitleLabel: UILabel = {
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
    
    
//    MARK: - Methods
    fileprivate func configure(with vm: MediaCellViewModel) {
        mediaTitleLabel.text = vm.title
        
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
        backgroundColor = .white
    }
    
    fileprivate func setupHierarhy() {
        addSubview(activityIndicatorView)
        addSubview(posterImageView)
        addSubview(mediaTitleLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.topAnchor.constraint(equalTo: topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            activityIndicatorView.leftAnchor.constraint(equalTo: leftAnchor),
            activityIndicatorView.rightAnchor.constraint(equalTo: rightAnchor),
            
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leftAnchor.constraint(equalTo: leftAnchor),
            posterImageView.rightAnchor.constraint(equalTo: rightAnchor),
            posterImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            
            mediaTitleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 12),
            mediaTitleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            mediaTitleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            mediaTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}
