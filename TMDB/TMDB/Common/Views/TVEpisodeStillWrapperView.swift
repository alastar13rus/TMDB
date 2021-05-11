//
//  TVEpisodeStillWrapperView.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.05.2021.
//

import UIKit

class TVEpisodeStillWrapperView: UIView {
    
//    MARK: - Properties
    let stillImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        addSubview(topView)
//        topView.addSubview(blurTopView)
        topView.addSubview(titleLabel)
        topView.addSubview(airYearLabel)
        
        addSubview(stillImageView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            topView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            topView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
//            blurTopView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
//            blurTopView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -8),
            
            airYearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            airYearLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -8),
            airYearLabel.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 8),
            airYearLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            
            stillImageView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            stillImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stillImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            stillImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
}

