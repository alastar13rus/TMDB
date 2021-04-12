//
//  TVCollectionViewLayout.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import UIKit

class TVCollectionViewLayout: UICollectionViewFlowLayout {
    
    //    MARK: - Init
    init(countItemsInRowOrColumn: Int, scrollDirection: UICollectionView.ScrollDirection, view: UIView) {
        super.init()
        
        configure(countItemsInRowOrColumn: countItemsInRowOrColumn, scrollDirection: scrollDirection, view: view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        }
        
    //    MARK: - Methods
    private func configure(countItemsInRowOrColumn: Int, scrollDirection: UICollectionView.ScrollDirection, view: UIView) {
        self.scrollDirection = scrollDirection
        let minimumInteritemSpacing: CGFloat = 8
        let sectionInset: UIEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        self.sectionInset = sectionInset
        self.minimumInteritemSpacing = minimumInteritemSpacing
        
        let itemWidth: CGFloat
        let itemHeight: CGFloat
        switch scrollDirection {
        case .vertical:
            itemHeight = 330 / CGFloat(countItemsInRowOrColumn) - CGFloat(countItemsInRowOrColumn - 1) * minimumInteritemSpacing
            itemWidth = itemHeight / 2
            
        case .horizontal:
            itemWidth = view.bounds.width / CGFloat(countItemsInRowOrColumn) - CGFloat(countItemsInRowOrColumn - 1) * minimumInteritemSpacing
            itemHeight = itemWidth * 1.6
        @unknown default:
            fatalError("Неизвестное значение параметра scrollDirection")
        }
        
        self.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
}
