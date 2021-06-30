//
//  ButtonTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import UIKit
import youtube_ios_player_helper

class ButtonTableViewCell: UITableViewCell {
    
// MARK: - Properties
    var viewModel: ButtonCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let trailerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "Смотреть трейлеры"
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.backgroundColor = .systemBlue
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
// MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupHierarhy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Methods
    fileprivate func configure(with vm: ButtonCellViewModel) {
        
    }
    
    fileprivate func setupUI() {
        selectionStyle = .none
    }
    
    fileprivate func setupHierarhy() {
        contentView.addSubview(trailerLabel)

    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            trailerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            trailerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            trailerLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            trailerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
}
