//
//  TVSeasonPosterWrapperTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 04.05.2021.
//

import UIKit

class TVSeasonPosterWrapperTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    var viewModel: TVSeasonPosterWrapperCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    var indexPath: IndexPath!
    
    let posterWrapperView: TVSeasonPosterWrapperView = {
        let view = TVSeasonPosterWrapperView()
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
        posterWrapperView.posterImageView.image = nil
        posterWrapperView.posterImageView.contentMode = .scaleAspectFill
    }
    
//    MARK: - Methods
    fileprivate func configure(with vm: TVSeasonPosterWrapperCellViewModel) {
        posterWrapperView.titleLabel.text = vm.name
        posterWrapperView.airYearLabel.text = vm.airYear
        
        let placeholder = #imageLiteral(resourceName: "mediaPlaceholder").withTintColor(.systemGray5, renderingMode: .alwaysOriginal)
        posterWrapperView.posterImageView.loadImage(with: vm.posterURL) { [weak self] (image) in
            guard let self = self, self.tag == self.indexPath.row else { return }
            
            guard let image = image else {
                self.posterWrapperView.posterImageView.image = placeholder
                self.posterWrapperView.posterImageView.contentMode = .scaleAspectFit
                return
            }
            
            self.posterWrapperView.posterImageView.contentMode = .scaleAspectFill
            return self.posterWrapperView.posterImageView.image = image
        }
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        addSubview(posterWrapperView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            
            posterWrapperView.topAnchor.constraint(equalTo: topAnchor),
            posterWrapperView.bottomAnchor.constraint(equalTo: bottomAnchor),
            posterWrapperView.leftAnchor.constraint(equalTo: leftAnchor),
            posterWrapperView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
    
}
