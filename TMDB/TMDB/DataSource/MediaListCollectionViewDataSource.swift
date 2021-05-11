//
//  MediaListCollectionViewDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 27.04.2021.
//

import Foundation
import RxDataSources

struct MediaListCollectionViewDataSource: DataSourceProtocol {
    
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<MediaCellViewModelMultipleSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .automatic, deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
            switch dataSource[indexPath] {
            case .movie(let vm):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MediaCollectionViewCell.self), for: indexPath) as? MediaCollectionViewCell else { return UICollectionViewCell() }
                cell.viewModel = vm
                return cell
            case .tv(let vm):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MediaCollectionViewCell.self), for: indexPath) as? MediaCollectionViewCell else { return UICollectionViewCell() }
                cell.viewModel = vm
                return cell
            }
        }
        
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
    }
    
}
