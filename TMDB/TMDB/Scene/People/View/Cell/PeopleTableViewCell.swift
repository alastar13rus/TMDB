//
//  PeopleTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 31.05.2021.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    var viewModel: PeopleCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let knownForLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
    }
    
//    MARK: - Methods
    fileprivate func setupUI() {
        selectionStyle = .none
    }
    
    fileprivate func setupHierarhy() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(knownForLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            profileImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            profileImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 3 / 4),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 12),
            nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12),
            nameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            knownForLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            knownForLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            knownForLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
        ])
    }
    
    fileprivate func configure(with vm: PeopleCellViewModel) {
        nameLabel.text = vm.name
        knownForLabel.text = vm.knownFor
        
        vm.profileImageData { [weak self] (data) in
            
            vm.profileImageData { [weak self] (imageData) in
                guard let self = self else { return }
                
                if imageData == nil {
                    self.profileImageView.contentMode = .scaleAspectFit
                    self.profileImageView.image = #imageLiteral(resourceName: "unknownGenderPlaceholder").withTintColor(.systemGray4, renderingMode: .alwaysOriginal)
                } else {
                    self.profileImageView.contentMode = .scaleAspectFill
                    self.profileImageView.image = UIImage(data: imageData!)
                }
            }
        }
    }
    
}
