//
//  CrewListDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 13.04.2021.
//

import Foundation
import RxDataSources

struct CrewListDataSource: DataSourceProtocol {
    
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<CrewCellViewModelSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(
            insertAnimation: .automatic,
            reloadAnimation: .automatic,
            deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
            if dataSource[indexPath].id == 999999 {
///            Вставить ячейку "Показать еще" в конец коллекции
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ShowMoreCell.self), for: indexPath) as! ShowMoreCell
                return cell
            }
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CrewCell.self), for: indexPath) as? CrewCell else { return UICollectionViewCell() }
            cell.viewModel = item
            return cell
        }
        
        return DataSource(
            animationConfiguration: animationConfiguration,
            configureCell: configureCell)
        
    }
    
}
