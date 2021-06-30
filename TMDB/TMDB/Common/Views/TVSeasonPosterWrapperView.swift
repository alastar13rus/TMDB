//
//  TVSeasonPosterWrapperView.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 04.05.2021.
//

import UIKit

class TVSeasonPosterWrapperView: UIView {
    
// MARK: - Properties
    let posterImageView = PosterImageView()
    
    let blurTopView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let airYearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray6
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
    
// MARK: - Methods
    private func setupUI() {
        
    }
    
    private func setupHierarhy() {
        addSubview(posterImageView)
        posterImageView.addSubview(blurTopView)
        posterImageView.addSubview(titleLabel)
        posterImageView.addSubview(airYearLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            posterImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            posterImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            blurTopView.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            blurTopView.leftAnchor.constraint(equalTo: posterImageView.leftAnchor),
            blurTopView.rightAnchor.constraint(equalTo: posterImageView.rightAnchor),

            titleLabel.topAnchor.constraint(equalTo: blurTopView.topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: blurTopView.leftAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: blurTopView.rightAnchor, constant: -8),

            airYearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            airYearLabel.bottomAnchor.constraint(equalTo: blurTopView.bottomAnchor, constant: -8),
            airYearLabel.leftAnchor.constraint(equalTo: blurTopView.leftAnchor, constant: 8),
            airYearLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor)
        ])
    }
    
}
