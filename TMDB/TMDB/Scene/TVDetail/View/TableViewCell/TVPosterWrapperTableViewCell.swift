//
//  TVPosterWrapperTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 09.04.2021.
//

import UIKit

class TVPosterWrapperTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    var viewModel: TVPosterWrapperCellViewModel! {
        didSet {
            self.configure(with: viewModel)
        }
    }
    
    let posterWrapperView: MediaPosterWrapperView = {
        let view = MediaPosterWrapperView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.startAnimating()
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
//    MARK: Init
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
    fileprivate func configure(with vm: TVPosterWrapperCellViewModel) {
        posterWrapperView.titleLabel.text = vm.title
        posterWrapperView.releaseYearLabel.text = vm.releaseYear
        posterWrapperView.taglineLabel.text = vm.tagline
        posterWrapperView.voteAverageCircleProgressBar.progress = CGFloat(vm.voteAverage)
        
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
            activityIndicatorView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            activityIndicatorView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            activityIndicatorView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            
            posterWrapperView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            posterWrapperView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            posterWrapperView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            posterWrapperView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
        ])
       
        
    }
}