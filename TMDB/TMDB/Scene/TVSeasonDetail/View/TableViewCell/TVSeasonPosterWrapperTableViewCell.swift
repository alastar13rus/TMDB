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
    
    let posterWrapperView: TVSeasonPosterWrapperView = {
        let view = TVSeasonPosterWrapperView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    fileprivate func configure(with vm: TVSeasonPosterWrapperCellViewModel) {
        posterWrapperView.titleLabel.text = vm.name
        posterWrapperView.airYearLabel.text = vm.airYear
    
        vm.posterImageData { [weak self] imageData in
            guard let self = self else { return }
            self.activityIndicatorView.stopAnimating()
            
            guard let imageData = imageData else {
                self.posterWrapperView.posterImageView.image = #imageLiteral(resourceName: "mediaPlaceholder").withTintColor(.systemGray4, renderingMode: .alwaysOriginal)
                return
            }

            self.posterWrapperView.posterImageView.image = UIImage(data: imageData)
        }
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        addSubview(activityIndicatorView)
        addSubview(posterWrapperView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.topAnchor.constraint(equalTo: topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            activityIndicatorView.leftAnchor.constraint(equalTo: leftAnchor),
            activityIndicatorView.rightAnchor.constraint(equalTo: rightAnchor),
            
            posterWrapperView.topAnchor.constraint(equalTo: topAnchor),
            posterWrapperView.bottomAnchor.constraint(equalTo: bottomAnchor),
            posterWrapperView.leftAnchor.constraint(equalTo: leftAnchor),
            posterWrapperView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
    
}
