//
//  MovieTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.03.2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    var viewModel: MovieCellViewModel! {
        didSet {
            self.configure(with: viewModel)
        }
    }
    
    var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var voteAverageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
    
//    MARK: - Methods
    private func configure(with vm: MovieCellViewModel) {

        layoutIfNeeded()
        titleLabel.text = vm.title
        overviewLabel.text = vm.overview
        voteAverageLabel.text = vm.voteAverage
        vm.posterImageData {[weak self] imageData in
            guard let self = self else { return }
            self.posterImageView.image = UIImage(data: imageData)
        }
        
    }
    
    private func setupUI() {
        
    }
    
    private func setupHierarhy() {
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(overviewLabel)
        addSubview(voteAverageLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            posterImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            posterImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.5),
            
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 8),
            
            overviewLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 8),
            overviewLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            overviewLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            overviewLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            
            voteAverageLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            voteAverageLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -8),
            voteAverageLabel.leftAnchor.constraint(greaterThanOrEqualTo: titleLabel.rightAnchor, constant: 8),
            
            
        ])
    }
    
}
