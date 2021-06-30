//
//  CrewCollectionViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 13.04.2021.
//

import UIKit

class CrewCollectionViewCell: UICollectionViewCell {
    
// MARK: - Properties
    var viewModel: CrewCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    var indexPath: IndexPath!
    
    let profileImageView = ProfileImageView()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
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
        self.profileImageView.contentMode = .scaleAspectFill
    }
    
// MARK: - Methods
    fileprivate func configure(with vm: CrewCellViewModel) {
        nameLabel.text = vm.name
        jobLabel.text = vm.job
        
        let placeholder = #imageLiteral(resourceName: "unknownGenderPlaceholder").withTintColor(.systemGray5, renderingMode: .alwaysOriginal)
        profileImageView.loadImage(with: vm.profileURL) { [weak self] (image) in
            guard let self = self, self.tag == self.indexPath.row else { return }
            
            guard let image = image else {
                self.profileImageView.image = placeholder
                self.profileImageView.contentMode = .scaleAspectFit
                return
            }
            return self.profileImageView.image = image
        }
    }
    
    fileprivate func setupUI() {
        backgroundColor = .white
    }
    
    fileprivate func setupHierarhy() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(jobLabel)

    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            profileImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.8),
            profileImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            profileImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            jobLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            jobLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            jobLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            jobLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
}
