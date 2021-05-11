//
//  CreditInMediaTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 24.04.2021.
//

import UIKit

class CreditInMediaTableViewCell: UITableViewCell {
    
//  MARK: - Properties
    var viewModel: CreditInMediaViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let mediaTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let characterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let voteAverageCircleProgressBar: CircleProgressBar = {
        let view = CircleProgressBar()
        view.isAnimating = true
        view.textColor = .black
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    
//    MARK: - Methods
    fileprivate func configure(with vm: CreditInMediaViewModel) {
        mediaTitleLabel.text = vm.mediaTitle
        characterLabel.text = vm.credit
        voteAverageCircleProgressBar.progress = CGFloat(vm.voteAverage * 10)
    }
    
    fileprivate func setupUI() {

    }
    
    fileprivate func setupHierarhy() {
        addSubview(mediaTitleLabel)
        addSubview(characterLabel)
        addSubview(voteAverageCircleProgressBar)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            mediaTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            mediaTitleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),

            characterLabel.topAnchor.constraint(equalTo: mediaTitleLabel.bottomAnchor, constant: 12),
            characterLabel.leftAnchor.constraint(equalTo: mediaTitleLabel.leftAnchor),
            characterLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            
            voteAverageCircleProgressBar.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            voteAverageCircleProgressBar.heightAnchor.constraint(equalToConstant: 50),
            voteAverageCircleProgressBar.widthAnchor.constraint(equalToConstant: 50),
            voteAverageCircleProgressBar.leftAnchor.constraint(equalTo: mediaTitleLabel.rightAnchor, constant: 12),
            voteAverageCircleProgressBar.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
        ])
    }
    
    
}
