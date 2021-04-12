//
//  TVCastListDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import Foundation
import RxDataSources

struct TVCastListDataSource {
    
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<TVCastCellViewModelSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(
            insertAnimation: .automatic,
            reloadAnimation: .automatic,
            deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
            if dataSource[indexPath].order == 99 {
///            Вставить ячейку "Показать еще" в конец коллекции
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ShowMoreCell.self), for: indexPath) as! ShowMoreCell
                return cell
            }
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TVCastCell.self), for: indexPath) as? TVCastCell else { return UICollectionViewCell() }
            cell.viewModel = item
            return cell
        }
        
        return DataSource(
            animationConfiguration: animationConfiguration,
            configureCell: configureCell)
        
    }
    
}
