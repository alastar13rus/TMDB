//
//  TVEpisodeShortListCollectionViewDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 05.05.2021.
//

import Foundation
import RxDataSources

struct TVEpisodeShortListCollectionViewDataSource: DataSourceProtocol {
    
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<TVEpisodeCellViewModelMultipleSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(
            insertAnimation: .automatic,
            reloadAnimation: .automatic,
            deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
            switch dataSource[indexPath] {
            case .episode(let vm):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TVEpisodeCollectionViewCell.self), for: indexPath) as? TVEpisodeCollectionViewCell else { return UICollectionViewCell() }
                cell.viewModel = vm
                return cell
            case .showMore(let vm):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ShowMoreCell.self), for: indexPath) as? ShowMoreCell else { return UICollectionViewCell() }
                cell.viewModel = vm
                return cell
            }
           
        }
        
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
        
    }
    
}
