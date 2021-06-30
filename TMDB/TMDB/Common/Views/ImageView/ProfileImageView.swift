//
//  ProfileImageView.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 25.06.2021.
//

import UIKit

class ProfileImageView: UIImageView {
    
// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 0)))
    }
    
// MARK: - Methods
    func setupUI() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.backgroundColor = .systemGray6
        self.contentMode = .scaleAspectFill
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
