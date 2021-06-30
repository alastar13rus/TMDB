//
//  TVPosterWrapperTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 09.04.2021.
//

import UIKit

class TVPosterWrapperTableViewCell: UITableViewCell {
    
// MARK: - Properties
    var viewModel: TVPosterWrapperCellViewModel! {
        didSet {
            self.configure(with: viewModel)
        }
    }
    var indexPath: IndexPath!
    
    let posterWrapperView: MediaPosterWrapperView = {
        let view = MediaPosterWrapperView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
// MARK: Init
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
    
// MARK: - Methods
    fileprivate func configure(with vm: TVPosterWrapperCellViewModel) {
        posterWrapperView.titleLabel.text = vm.title
        posterWrapperView.releaseYearLabel.text = vm.releaseYear
        posterWrapperView.taglineLabel.isHidden = vm.tagline.isEmpty ? true : false
        posterWrapperView.blurBottomView.isHidden = vm.tagline.isEmpty ? true : false
        posterWrapperView.taglineLabel.text = vm.tagline
        posterWrapperView.voteAverageCircleProgressBar.progress = CGFloat(vm.voteAverage)
        
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
            posterWrapperView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            posterWrapperView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            posterWrapperView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            posterWrapperView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor)
        ])
        
    }
}
