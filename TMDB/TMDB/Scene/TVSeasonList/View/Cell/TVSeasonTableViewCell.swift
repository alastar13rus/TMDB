//
//  TVSeasonTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 01.05.2021.
//

import UIKit

class TVSeasonTableViewCell: UITableViewCell {
    
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
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let airDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let episodeCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.startAnimating()
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
//    MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupHierarhy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
    }
    
//    MARK: - Methods
    fileprivate func configure(with vm: TVSeasonCellViewModel) {
        nameLabel.text = vm.name
        airDateLabel.text = vm.airDateText
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

    }
    
    fileprivate func setupHierarhy() {
        addSubview(activityIndicatorView)
        addSubview(posterImageView)
        addSubview(nameLabel)
        addSubview(airDateLabel)
        addSubview(episodeCountLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.topAnchor.constraint(equalTo: topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            activityIndicatorView.leftAnchor.constraint(equalTo: leftAnchor),
            activityIndicatorView.rightAnchor.constraint(equalTo: rightAnchor),
            
            posterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            posterImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            posterImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 3 / 4),
            
            nameLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 12),
            nameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            airDateLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            airDateLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            
            episodeCountLabel.topAnchor.constraint(equalTo: airDateLabel.bottomAnchor, constant: 12),
            episodeCountLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            episodeCountLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
        ])
    }
    
}
