//
//  MediaTrailerCollectionViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 30.04.2021.
//

import UIKit
import youtube_ios_player_helper

class MediaTrailerCollectionViewCell: UICollectionViewCell {
    
//    MARK: - Properties
    var viewModel: MediaTrailerCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let player: YTPlayerView = {
        let view = YTPlayerView()
        view.load(withVideoId: "MJPdA2xWfII")
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let trailerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
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
    fileprivate func configure(with vm: MediaTrailerCellViewModel) {
        player.load(withVideoId: vm.key)
//        player.playVideo()
        trailerLabel.text = vm.name
    }
    
    fileprivate func setupUI() {
        backgroundColor = .systemGray5
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    fileprivate func setupHierarhy() {
        addSubview(player)
        addSubview(trailerLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            player.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            player.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            player.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),

            trailerLabel.topAnchor.constraint(equalTo: player.bottomAnchor, constant: 12),
            trailerLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            trailerLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            trailerLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
        ])
    }
    
}
