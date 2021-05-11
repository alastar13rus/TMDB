//
//  PeopleImageCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.04.2021.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
//    MARK: - Properties
    var viewModel: ImageCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let imageView: UIImageView = {
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
        imageView.image = nil
    }
    
//    MARK: - Methods
    fileprivate func configure(with vm: ImageCellViewModel) {
        vm.imageData { [weak self] (data) in
            
            vm.imageData { [weak self] (imageData) in
                guard let self = self else { return }
                
                if imageData == nil {
                    self.imageView.contentMode = .scaleAspectFit
                    self.imageView.image = #imageLiteral(resourceName: "mediaPlaceholder")
                } else {
                    self.imageView.contentMode = .scaleAspectFill
                    self.imageView.image = UIImage(data: imageData!)
                }
            }
        }
    }
    
    fileprivate func setupUI() {

    }
    
    fileprivate func setupHierarhy() {
        addSubview(imageView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
        
    }
    
}
