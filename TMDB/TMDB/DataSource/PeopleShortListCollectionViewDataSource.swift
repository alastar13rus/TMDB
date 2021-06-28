//
//  PeopleShortListCollectionViewDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import Foundation
import RxDataSources

struct PeopleShortListCollectionViewDataSource: DataSourceProtocol {
    
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<PeopleShortListViewModelSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .automatic, deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PeopleCollectionViewCell.self), for: indexPath) as? PeopleCollectionViewCell else { return UICollectionViewCell() }
            cell.tag = indexPath.row
            cell.indexPath = indexPath
            cell.viewModel = item
            return cell
            
        }
        
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
    }
    
}
