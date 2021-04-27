//
//  PeopleImageCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.04.2021.
//

import UIKit

class PeopleImageCell: UICollectionViewCell {
    
//    MARK: - Properties
    var viewModel: PeopleImageCellViewModel! {
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
        profileImageView.image = nil
    }
    
//    MARK: - Methods
    fileprivate func configure(with vm: PeopleImageCellViewModel) {
        vm.profileImageData { [weak self] (data) in
            
            vm.profileImageData { [weak self] (imageData) in
                guard let self = self else { return }
                self.profileImageView.image = UIImage(data: imageData!)
            }
        }
    }
    
    fileprivate func setupUI() {

    }
    
    fileprivate func setupHierarhy() {
        addSubview(profileImageView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            profileImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            profileImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
        
    }
    
}
