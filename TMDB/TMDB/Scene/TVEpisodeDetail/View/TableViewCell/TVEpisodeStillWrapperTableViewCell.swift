//
//  TVEpisodeStillWrapperTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.05.2021.
//

import UIKit

class TVEpisodeStillWrapperTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    var viewModel: TVEpisodeStillWrapperCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    var indexPath: IndexPath!
    
    let stillWrapperView: TVEpisodeStillWrapperView = {
        let view = TVEpisodeStillWrapperView()
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stillWrapperView.stillImageView.image = nil
        stillWrapperView.stillImageView.contentMode = .scaleAspectFill
    }
    
//    MARK: - Methods
    fileprivate func configure(with vm: TVEpisodeStillWrapperCellViewModel) {
        stillWrapperView.titleLabel.text = vm.name
        stillWrapperView.airYearLabel.text = vm.airYear
        
        let placeholder = #imageLiteral(resourceName: "mediaPlaceholder").withTintColor(.systemGray5, renderingMode: .alwaysOriginal)
        stillWrapperView.stillImageView.loadImage(with: vm.stillURL) { [weak self] (image) in
            guard let self = self, self.tag == self.indexPath.row else { return }
            
            guard let image = image else {
                self.stillWrapperView.stillImageView.image = placeholder
                self.stillWrapperView.stillImageView.contentMode = .scaleAspectFit
                return
            }
            
            self.stillWrapperView.stillImageView.contentMode = .scaleAspectFill
            return self.stillWrapperView.stillImageView.image = image
        }
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        contentView.addSubview(stillWrapperView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            stillWrapperView.topAnchor.constraint(equalTo: topAnchor),
            stillWrapperView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stillWrapperView.leftAnchor.constraint(equalTo: leftAnchor),
            stillWrapperView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
    
}
