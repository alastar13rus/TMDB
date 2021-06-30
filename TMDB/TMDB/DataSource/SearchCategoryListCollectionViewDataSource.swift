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
    
    private static let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic,
                                                        reloadAnimation: .automatic,
                                                        deleteAnimation: .automatic)
    
    private static let configureCell: DataSource.ConfigureCell = { (_, cv, ip, item) -> UICollectionViewCell in
        let reuseId = SearchCategoryCollectionViewCell.reuseId
        
        guard let cell = cv.dequeueReusableCell(withReuseIdentifier: reuseId, for: ip) as? SearchCategoryCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.viewModel = item
        return cell
    }
    
    static func dataSource() -> DataSource {
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
    }
    
}
