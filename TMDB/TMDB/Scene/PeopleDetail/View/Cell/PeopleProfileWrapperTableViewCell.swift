//
//  PeopleProfileWrapperTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.04.2021.
//

import UIKit

class PeopleProfileWrapperTableViewCell: UITableViewCell {
    
// MARK: - Properties
    var viewModel: PeopleProfileWrapperCellViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    var indexPath: IndexPath!
    
    let profileImageView = ProfileImageView()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deathdayLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        profileImageView.contentMode = .scaleAspectFill
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        
        selectionStyle = .none
    }
    
// MARK: - Methods
    fileprivate func configure(with vm: PeopleProfileWrapperCellViewModel) {
        nameLabel.text = vm.name
        jobLabel.text = vm.job
        birthdayLabel.text = vm.placeAndBirthdayText
        deathdayLabel.text = vm.deathdayText
        
        let placeholder = #imageLiteral(resourceName: "unknownGenderPlaceholder").withTintColor(.systemGray5, renderingMode: .alwaysOriginal)
        profileImageView.loadImage(with: vm.profileURL) { [weak self] (image) in
            guard let self = self, self.tag == self.indexPath.row else { return }
            
            guard let image = image else {
                self.profileImageView.image = placeholder
                self.profileImageView.contentMode = .scaleAspectFit
                return
            }
            return self.profileImageView.image = image
        }
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(jobLabel)
        addSubview(birthdayLabel)
        addSubview(deathdayLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            profileImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
//            imageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, constant: -24),
            profileImageView.heightAnchor.constraint(equalToConstant: 176),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 3 / 4),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12),
            nameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
            
            jobLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            jobLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            jobLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            
            birthdayLabel.topAnchor.constraint(equalTo: jobLabel.bottomAnchor, constant: 12),
            birthdayLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            birthdayLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            
            deathdayLabel.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 12),
            deathdayLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            deathdayLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            deathdayLabel.bottomAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -12)

        ])
    }
    
}
