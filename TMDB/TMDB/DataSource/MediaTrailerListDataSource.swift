//
//  MediaTrailerListDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation
import RxDataSources

struct MediaTrailerListDataSource: DataSourceProtocol {
    
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<MediaTrailerCellViewModelSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .automatic, deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MediaTrailerCollectionViewCell.self), for: indexPath) as? MediaTrailerCollectionViewCell else { return UICollectionViewCell() }
            cell.viewModel = item
            return cell
        }
        
        return DataSource(
            animationConfiguration: animationConfiguration,
            configureCell: configureCell)
    }
    
}
