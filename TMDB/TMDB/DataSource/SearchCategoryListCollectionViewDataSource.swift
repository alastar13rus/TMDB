//
//  SearchCategoryListCollectionViewDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import Foundation
import RxDataSources

struct SearchCategoryListCollectionViewDataSource: DataSourceProtocol {
    
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<SearchCategoryListViewModelSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .automatic, deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SearchCategoryCollectionViewCell.self), for: indexPath) as? SearchCategoryCollectionViewCell else { return UICollectionViewCell() }
            cell.viewModel = item
            return cell
            
        }
        
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
    }
    
}
