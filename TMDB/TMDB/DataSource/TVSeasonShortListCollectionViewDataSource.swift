//
//  TVSeasonShortListCollectionViewDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 01.05.2021.
//

import Foundation
import RxDataSources

struct TVSeasonShortListCollectionViewDataSource: DataSourceProtocol {
    
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<TVSeasonCellViewModelMultipleSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(
            insertAnimation: .automatic,
            reloadAnimation: .automatic,
            deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
            switch dataSource[indexPath] {
            case .season(let vm):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TVSeasonCollectionViewCell.self), for: indexPath) as? TVSeasonCollectionViewCell else { return UICollectionViewCell() }
                cell.viewModel = vm
                cell.indexPath = indexPath
                cell.tag = indexPath.row
                cell.tag = indexPath.row
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
