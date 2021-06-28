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
    var indexPath: IndexPath!
    let posterImageView = PosterImageView()
    
    let mediaTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
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
        posterImageView.image = nil
        posterImageView.contentMode = .scaleAspectFill
    }
    
    
//    MARK: - Methods
    fileprivate func configure(with vm: MediaCellViewModel) {
        mediaTitleLabel.text = vm.title
        
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
        backgroundColor = .white
    }
    
    fileprivate func setupHierarhy() {
        addSubview(posterImageView)
        addSubview(mediaTitleLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            
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
