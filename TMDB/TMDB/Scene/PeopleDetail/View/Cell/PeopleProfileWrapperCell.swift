//
//  PeopleProfileWrapperCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.04.2021.
//

import UIKit

class PeopleProfileWrapperCell: UITableViewCell {
    
//    MARK: - Properties
    var viewModel: PeopleProfileWrapperCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deathdayLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16)
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
    fileprivate func configure(with vm: PeopleProfileWrapperCellViewModel) {
        nameLabel.text = vm.name
        jobLabel.text = vm.job
        birthdayLabel.text = vm.placeAndBirthday
        deathdayLabel.text = vm.deathday
        
        vm.profileImageData { [weak self] (data) in
            guard let self = self, let imageData = data else { return }
            self.activityIndicatorView.stopAnimating()
            self.profileImageView.image = UIImage(data: imageData)
        }
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        addSubview(activityIndicatorView)
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(jobLabel)
        addSubview(birthdayLabel)
        addSubview(deathdayLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            
            activityIndicatorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            activityIndicatorView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            activityIndicatorView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            profileImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
//            profileImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, constant: -24),
            profileImageView.heightAnchor.constraint(equalToConstant: 176),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 3 / 4),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12),
            nameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
            
            jobLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            jobLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            jobLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            
            birthdayLabel.topAnchor.constraint(equalTo: jobLabel.bottomAnchor, constant: 12),
            birthdayLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            birthdayLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            
            deathdayLabel.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 12),
            deathdayLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            deathdayLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
//            deathdayLabel.bottomAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),

        ])
    }
    
}
