//
//  PeopleImageListDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.04.2021.
//

import Foundation
import RxDataSources

struct PeopleImageListDataSource: DataSourceProtocol {
    
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<PeopleImageCellViewModelMultipleSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .automatic, deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, collectionview, indexPath, item) -> UICollectionViewCell in
            guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: String(describing: PeopleImageCell.self), for: indexPath) as? PeopleImageCell else { return UICollectionViewCell() }
            cell.viewModel = item
            return cell
        }
        
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
    }
    
}
