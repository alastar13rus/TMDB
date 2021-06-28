//
//  TVEpisodeTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.05.2021.
//

import UIKit

class TVEpisodeTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    var viewModel: TVEpisodeCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    var indexPath: IndexPath!
    
    let stillImageView = StillImageView()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let airDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stillImageView.image = nil
        stillImageView.contentMode = .scaleAspectFill
    }
    
//    MARK: - Methods
    fileprivate func configure(with vm: TVEpisodeCellViewModel) {
        nameLabel.text = vm.name
        airDateLabel.text = vm.airDateText
        
        let placeholder = #imageLiteral(resourceName: "mediaPlaceholder").withTintColor(.systemGray5, renderingMode: .alwaysOriginal)
        stillImageView.loadImage(with: vm.stillURL) { [weak self] (image) in
            guard let self = self, self.tag == self.indexPath.row else { return }
            
            guard let image = image else {
                self.stillImageView.image = placeholder
                self.stillImageView.contentMode = .scaleAspectFit
                return
            }
            
            self.stillImageView.contentMode = .scaleAspectFill
            return self.stillImageView.image = image
        }
    }
    
    fileprivate func setupUI() {

    }
    
    fileprivate func setupHierarhy() {
        contentView.addSubview(stillImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(airDateLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            
            stillImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            stillImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            stillImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            stillImageView.widthAnchor.constraint(equalTo: stillImageView.heightAnchor, multiplier: 3 / 4),
            
            nameLabel.topAnchor.constraint(equalTo: stillImageView.topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: stillImageView.rightAnchor, constant: 12),
            nameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            airDateLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            airDateLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            airDateLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}
