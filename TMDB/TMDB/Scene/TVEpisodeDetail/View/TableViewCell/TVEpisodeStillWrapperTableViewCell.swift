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
    
    let stillWrapperView: TVEpisodeStillWrapperView = {
        let view = TVEpisodeStillWrapperView()
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
    fileprivate func configure(with vm: TVEpisodeStillWrapperCellViewModel) {
        stillWrapperView.titleLabel.text = vm.name
        stillWrapperView.airYearLabel.text = vm.airYear
    
        vm.stillImageData { [weak self] imageData in
            guard let self = self else { return }
            self.activityIndicatorView.stopAnimating()
            
            guard let imageData = imageData else {
                self.stillWrapperView.stillImageView.image = #imageLiteral(resourceName: "mediaPlaceholder").withTintColor(.systemGray4, renderingMode: .alwaysOriginal)
                return
            }

            self.stillWrapperView.stillImageView.image = UIImage(data: imageData)
        }
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        addSubview(activityIndicatorView)
        addSubview(stillWrapperView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.topAnchor.constraint(equalTo: topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            activityIndicatorView.leftAnchor.constraint(equalTo: leftAnchor),
            activityIndicatorView.rightAnchor.constraint(equalTo: rightAnchor),
            
            stillWrapperView.topAnchor.constraint(equalTo: topAnchor),
            stillWrapperView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stillWrapperView.leftAnchor.constraint(equalTo: leftAnchor),
            stillWrapperView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
    
}
