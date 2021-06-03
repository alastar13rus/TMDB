//
//  MediaTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 112.03.2021.
//

import UIKit

class MediaTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    var viewModel: MediaCellViewModel! {
        didSet {
            self.configure(with: viewModel)
        }
    }
    
    var posterImageView: UIImageView = {
        let imageView = UIImageView()
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
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .right
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var voteAverageCircleProgressBar: CircleProgressBar = {
        let view = CircleProgressBar()
        view.isAnimating = true
        view.counterDuration = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    override func prepareForReuse() {
        posterImageView.image = nil
    }
    
    private func configure(with vm: MediaCellViewModel) {
        
        titleLabel.text = vm.title
        overviewLabel.text = vm.overview
        voteAverageCircleProgressBar.progress = vm.voteAverage
        
        vm.posterImageData { [weak self] imageData in
            guard let self = self else { return }
            self.posterImageView.layer.opacity = 0
            UIView.animate(withDuration: 0.2) {
                self.posterImageView.layer.opacity = 1
                
                guard let imageData = imageData else {
                    self.posterImageView.contentMode = .scaleAspectFit
                    self.posterImageView.image = #imageLiteral(resourceName: "mediaPlaceholder").withTintColor(.systemGray4, renderingMode: .alwaysOriginal)
                    return
                }
                
                self.posterImageView.contentMode = .scaleAspectFill
                self.posterImageView.image = UIImage(data: imageData)
            }
        }
        
    }
    
    private func setupUI() {
        selectionStyle = .none
    }
    
    private func setupHierarhy() {
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(overviewLabel)
        addSubview(voteAverageCircleProgressBar)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            posterImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            posterImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 3 / 4),
            
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 12),
            
            overviewLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 16),
            overviewLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            overviewLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            overviewLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            
            voteAverageCircleProgressBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            voteAverageCircleProgressBar.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
            voteAverageCircleProgressBar.leftAnchor.constraint(greaterThanOrEqualTo: titleLabel.rightAnchor, constant: 12),
            voteAverageCircleProgressBar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            voteAverageCircleProgressBar.widthAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
}
