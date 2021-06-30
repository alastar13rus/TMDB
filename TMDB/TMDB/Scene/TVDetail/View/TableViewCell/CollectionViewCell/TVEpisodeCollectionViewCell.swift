//
//  TVEpisodeCollectionViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.05.2021.
//

import UIKit

class TVEpisodeCollectionViewCell: UICollectionViewCell {
    
// MARK: - Properties
    
    var viewModel: TVEpisodeCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    var indexPath: IndexPath!
    
    let stillImageView = StillImageView()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stillImageView.image = nil
        stillImageView.contentMode = .scaleAspectFill
    }
    
// MARK: - Methods
    
    fileprivate func configure(with vm: TVEpisodeCellViewModel) {
        nameLabel.text = vm.name
        episodeNumberLabel.text = "Эпизод \(vm.episodeNumber)"
        
        let placeholder = #imageLiteral(resourceName: "mediaPlaceholder").withTintColor(.systemGray5, renderingMode: .alwaysOriginal)
        stillImageView.loadImage(with: vm.stillURL) { [weak self] (image) in
            guard let self = self, self.tag == self.indexPath.row else { return }
            
            guard let image = image else {
                self.stillImageView.image = placeholder
                self.stillImageView.contentMode = .scaleAspectFit
                return
            }
            
            self.stillImageView.contentMode = .scaleAspectFill
            return self.stillImageView.image = image
        }
    }
    
    fileprivate func setupUI() {
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemGray6
        
    }
    
    fileprivate func setupHierarhy() {
        addSubview(stillImageView)
        addSubview(episodeNumberLabel)
        addSubview(nameLabel)
    }
    
    fileprivate func setupConstraints() {
            NSLayoutConstraint.activate([
                
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
                nameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
}
