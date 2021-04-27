//
//  MediaPosterWrapperView.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 08.04.2021.
//

import UIKit

class MediaPosterWrapperView: UIView {
    
//    MARK: - Properties
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let blurTopView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let blurBottomView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
//        label.text = "Game of Thrones rgree  ebetb errver er et jhfjegwjf hwrw wrkgnmrkwnvj wnrjvn wjrnv jenjv nwr nvkern vkjewnr jkner kjrnjg hjrw "
//        label.text = "Game of Thrones"
        label.numberOfLines = 5
        label.textColor = .white
//        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releaseYearLabel: UILabel = {
        let label = UILabel()
//        label.text = "(2011)"
        label.textColor = .systemGray6
//        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let taglineLabel: UILabel = {
        let label = UILabel()
//        label.text = "Зима близко"
        label.numberOfLines = 5
        label.textColor = .systemGray6
        label.textAlignment = .center
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let voteAverageCircleProgressBar: CircleProgressBar = {
        let view = CircleProgressBar()
        view.isAnimating = true
//        view.progress = 99
        view.textColor = .white
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
//    MARK: - Methods
    private func setupUI() {
        
    }
    
    private func setupHierarhy() {
        addSubview(posterImageView)
        posterImageView.addSubview(blurTopView)
        posterImageView.addSubview(blurBottomView)
        posterImageView.addSubview(titleLabel)
        posterImageView.addSubview(releaseYearLabel)
        posterImageView.addSubview(taglineLabel)
        posterImageView.addSubview(voteAverageCircleProgressBar)
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
            
            releaseYearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            releaseYearLabel.bottomAnchor.constraint(equalTo: blurTopView.bottomAnchor, constant: -8),
            releaseYearLabel.leftAnchor.constraint(equalTo: blurTopView.leftAnchor, constant: 8),
            releaseYearLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            
            voteAverageCircleProgressBar.centerYAnchor.constraint(equalTo: blurTopView.centerYAnchor),
            voteAverageCircleProgressBar.rightAnchor.constraint(equalTo: blurTopView.rightAnchor, constant: -8),
            voteAverageCircleProgressBar.heightAnchor.constraint(equalToConstant: 50),
            voteAverageCircleProgressBar.widthAnchor.constraint(equalToConstant: 50),
            voteAverageCircleProgressBar.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 8),
            
            blurBottomView.topAnchor.constraint(greaterThanOrEqualTo: blurTopView.bottomAnchor, constant: 8),
            blurBottomView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            blurBottomView.leftAnchor.constraint(equalTo: posterImageView.leftAnchor),
            blurBottomView.rightAnchor.constraint(equalTo: posterImageView.rightAnchor),
            
            taglineLabel.topAnchor.constraint(equalTo: blurBottomView.topAnchor, constant: 8),
            taglineLabel.bottomAnchor.constraint(equalTo: blurBottomView.bottomAnchor, constant: -8),
            taglineLabel.leftAnchor.constraint(equalTo: blurBottomView.leftAnchor, constant: 8),
            taglineLabel.rightAnchor.constraint(equalTo: blurBottomView.rightAnchor, constant: -8),
        ])
    }
    
}

