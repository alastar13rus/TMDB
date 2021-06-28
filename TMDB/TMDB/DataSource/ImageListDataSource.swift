//
//  ImageListDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.04.2021.
//

import Foundation
import RxDataSources

struct ImageListDataSource: DataSourceProtocol {
    
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<ImageCellViewModelMultipleSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .automatic, deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, collectionview, indexPath, item) -> UICollectionViewCell in
            guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCell.self), for: indexPath) as? ImageCell else { return UICollectionViewCell() }
            cell.viewModel = item
            cell.indexPath = indexPath
            cell.tag = indexPath.row
            return cell
        }
        
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
    }
    
}
