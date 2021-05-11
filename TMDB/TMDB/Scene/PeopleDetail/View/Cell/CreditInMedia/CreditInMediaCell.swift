//
//  CreditInMediaCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.04.2021.
//

import UIKit

class CreditInMediaCell: UICollectionViewCell {
    
//    MARK: - Properties
    var viewModel: CreditInMediaViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let mediaPosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let mediaTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let creditLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        mediaPosterImageView.image = nil
    }
    
//    MARK: - Methods
    fileprivate func configure(with vm: CreditInMediaViewModel) {
        mediaTitleLabel.text = vm.mediaTitle
        creditLabel.text = vm.credit
        
        vm.mediaPosterImageView { [weak self] (data) in
            guard let self = self else { return }
            guard let imageData = data else {
                self.mediaPosterImageView.contentMode = .scaleAspectFit
                self.mediaPosterImageView.image = #imageLiteral(resourceName: "mediaPlaceholder").withTintColor(.systemGray4, renderingMode: .alwaysOriginal)
                return
            }
            self.mediaPosterImageView.contentMode = .scaleAspectFill
            self.mediaPosterImageView.image = UIImage(data: imageData)
        }
    }
    
    fileprivate func setupUI() {

    }
    
    fileprivate func setupHierarhy() {
        contentView.addSubview(mediaPosterImageView)
        contentView.addSubview(mediaTitleLabel)
        contentView.addSubview(creditLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            mediaPosterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            mediaPosterImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            mediaPosterImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            
            mediaTitleLabel.topAnchor.constraint(equalTo: mediaPosterImageView.bottomAnchor, constant: 4),
            mediaTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            mediaTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            
            creditLabel.topAnchor.constraint(equalTo: mediaTitleLabel.bottomAnchor, constant: 4),
            creditLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            creditLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            creditLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),

        ])
    }
}
