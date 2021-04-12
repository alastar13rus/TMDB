//
//  TVCastListCollectionView.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import UIKit

class TVCastListCollectionView: UICollectionView {
    
    
//    MARK: - Init
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
