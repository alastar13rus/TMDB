//
//  CollectionViewLayout.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import UIKit

class CollectionViewLayout: UICollectionViewFlowLayout {
    
    // MARK: - Init
    init(countItemsInScrollDirection: Int, scrollDirection: UICollectionView.ScrollDirection, contentForm: ContentForm, view: UIView) {
        super.init()
        
        configure(countItemsInRowOrColumn: countItemsInScrollDirection, scrollDirection: scrollDirection, contentForm: contentForm, view: view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        }
        
    // MARK: - Methods
    private func configure(countItemsInRowOrColumn: Int, scrollDirection: UICollectionView.ScrollDirection, contentForm: ContentForm, view: UIView) {
        self.scrollDirection = scrollDirection
        let minimumInteritemSpacing: CGFloat = 12
        let sectionInset: UIEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        self.sectionInset = sectionInset
        self.minimumInteritemSpacing = minimumInteritemSpacing
        
        let itemWidth: CGFloat
        let itemHeight: CGFloat
        switch scrollDirection {
        case .vertical:
            itemHeight = view.bounds.width / CGFloat(countItemsInRowOrColumn) - CGFloat(countItemsInRowOrColumn - 1) * minimumInteritemSpacing
            itemWidth = view.bounds.width / CGFloat(countItemsInRowOrColumn)
            
        case .horizontal:
            switch contentForm {
            case .landscape:
                itemWidth =
                    (
                        view.bounds.width
                        + 55
                        - CGFloat(countItemsInRowOrColumn - 1)
                        * minimumInteritemSpacing
                        - sectionInset.left
                        - sectionInset.right
                    ) / CGFloat(countItemsInRowOrColumn)
                itemHeight = itemWidth / 1.6
            case .portrait:
                itemWidth =
                    (
                        view.bounds.width
                        + 55
                        - CGFloat(countItemsInRowOrColumn - 1)
                        * minimumInteritemSpacing
                        - sectionInset.left
                        - sectionInset.right
                    ) / CGFloat(countItemsInRowOrColumn)
                itemHeight = itemWidth * 1.6
            default:
                itemWidth =
                    (
                        view.bounds.width
                        + 55
                        - CGFloat(countItemsInRowOrColumn - 1)
                        * minimumInteritemSpacing
                        - sectionInset.left
                        - sectionInset.right)
                / CGFloat(countItemsInRowOrColumn)
                itemHeight = itemWidth
            }
            
        @unknown default:
            fatalError("Неизвестное значение параметра scrollDirection")
        }
        
        self.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
}
