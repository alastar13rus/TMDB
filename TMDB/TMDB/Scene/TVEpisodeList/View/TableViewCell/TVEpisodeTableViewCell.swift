//
//  TVEpisodeTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.05.2021.
//

import UIKit

class TVEpisodeTableViewCell: UITableViewCell {
    
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
    fileprivate func configure(with vm: TVEpisodeCellViewModel) {
        nameLabel.text = vm.name
        airDateLabel.text = vm.airDateText
        
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

    }
    
    fileprivate func setupHierarhy() {
        addSubview(activityIndicatorView)
        addSubview(stillImageView)
        addSubview(nameLabel)
        addSubview(airDateLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.topAnchor.constraint(equalTo: topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            activityIndicatorView.leftAnchor.constraint(equalTo: leftAnchor),
            activityIndicatorView.rightAnchor.constraint(equalTo: rightAnchor),
            
            stillImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            stillImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            stillImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            stillImageView.widthAnchor.constraint(equalTo: stillImageView.heightAnchor, multiplier: 3 / 4),
            
            nameLabel.topAnchor.constraint(equalTo: stillImageView.topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: stillImageView.rightAnchor, constant: 12),
            nameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            airDateLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            airDateLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            airDateLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}
