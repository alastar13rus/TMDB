//
//  TVSeasonCollectionViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 01.05.2021.
//

import UIKit

class TVSeasonCollectionViewCell: UICollectionViewCell {
    
// MARK: - Properties
    
    var viewModel: TVSeasonCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    var indexPath: IndexPath!
    let posterImageView = PosterImageView()
    
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
        posterImageView.image = nil
        posterImageView.contentMode = .scaleAspectFill
    }
    
// MARK: - Methods
    
    fileprivate func configure(with vm: TVSeasonCellViewModel) {
        nameLabel.text = vm.name
        episodeCountLabel.text = "\(vm.episodeCountText)"
        
        let placeholder = #imageLiteral(resourceName: "mediaPlaceholder").withTintColor(.systemGray5, renderingMode: .alwaysOriginal)
        posterImageView.loadImage(with: vm.posterURL) { [weak self] (image) in
            guard let self = self, self.tag == self.indexPath.row else { return }
            
            guard let image = image else {
                self.posterImageView.image = placeholder
                self.posterImageView.contentMode = .scaleAspectFit
                return
            }
            
            self.posterImageView.contentMode = .scaleAspectFill
            return self.posterImageView.image = image 
        }

    }
    
    fileprivate func setupUI() {
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemGray6
        
    }
    
    fileprivate func setupHierarhy() {
        addSubview(posterImageView)
        addSubview(nameLabel)
        addSubview(episodeCountLabel)
    }
    
    fileprivate func setupConstraints() {
            NSLayoutConstraint.activate([
                posterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                posterImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
                posterImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor),

                nameLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
                nameLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 12),
                nameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
                
                episodeCountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
                episodeCountLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
                episodeCountLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor)
            ])
    }
    
}
