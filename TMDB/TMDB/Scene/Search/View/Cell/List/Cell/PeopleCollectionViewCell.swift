//
//  PeopleCollectionViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import UIKit

class PeopleCollectionViewCell: UICollectionViewCell {
    
// MARK: - Properties
    var viewModel: PeopleCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    var indexPath: IndexPath!
    
    let profileImageView = ProfileImageView()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
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
        profileImageView.image = nil
        profileImageView.contentMode = .scaleAspectFill
    }
    
// MARK: - Methods
    fileprivate func setupUI() {
//        backgroundColor = .systemGray5
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    fileprivate func setupHierarhy() {
        addSubview(profileImageView)
        addSubview(nameLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            profileImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            profileImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 4 / 3),
            
            nameLabel.leftAnchor.constraint(equalTo: profileImageView.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: profileImageView.rightAnchor),
            nameLabel.bottomAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }
    
    fileprivate func configure(with vm: PeopleCellViewModel) {
        nameLabel.text = vm.name
        
        let placeholder = #imageLiteral(resourceName: "unknownGenderPlaceholder").withTintColor(.systemGray5, renderingMode: .alwaysOriginal)
        profileImageView.loadImage(with: vm.profileURL) { [weak self] (image) in
            guard let self = self, self.tag == self.indexPath.row else { return }
            
            guard let image = image else {
                self.profileImageView.image = placeholder
                self.profileImageView.contentMode = .scaleAspectFit
                return
            }
            return  self.profileImageView.image = image
        }
    }
}
