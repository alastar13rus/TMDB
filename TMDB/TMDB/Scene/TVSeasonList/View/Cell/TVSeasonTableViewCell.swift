//
//  TVSeasonTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 01.05.2021.
//

import UIKit

class TVSeasonTableViewCell: UITableViewCell {
    
// MARK: - Properties
    var viewModel: TVSeasonCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    var indexPath: IndexPath!
    let posterImageView = PosterImageView()
    
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
    
    let episodeCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        posterImageView.image = nil
        posterImageView.contentMode = .scaleAspectFill
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
    }
    
// MARK: - Methods
    fileprivate func configure(with vm: TVSeasonCellViewModel) {
        nameLabel.text = vm.name
        airDateLabel.text = vm.airDateText
        episodeCountLabel.text = "\(vm.episodeCountText)"
        
        let placeholder = #imageLiteral(resourceName: "mediaPlaceholder").withTintColor(.systemGray5, renderingMode: .alwaysOriginal)
        posterImageView.loadImage(with: vm.posterURL) { [weak self] (image) in
            guard let self = self, self.tag == self.indexPath.row else { return }
            
            guard let image = image else {
                self.posterImageView.image = placeholder
                self.posterImageView.contentMode = .scaleAspectFit
                return
            }
            
            self.posterImageView.contentMode = .scaleAspectFill
            return self.posterImageView.image = image
        }
    }
    
    fileprivate func setupUI() {

    }
    
    fileprivate func setupHierarhy() {
        addSubview(posterImageView)
        addSubview(nameLabel)
        addSubview(airDateLabel)
        addSubview(episodeCountLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            posterImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            posterImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 3 / 4),
            
            nameLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 12),
            nameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            airDateLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            airDateLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            
            episodeCountLabel.topAnchor.constraint(equalTo: airDateLabel.bottomAnchor, constant: 12),
            episodeCountLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            episodeCountLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor)
        ])
    }
    
}
