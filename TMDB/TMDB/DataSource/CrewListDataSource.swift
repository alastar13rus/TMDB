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
    
    private static let animationConfiguration = AnimationConfiguration(
        insertAnimation: .automatic,
        reloadAnimation: .automatic,
        deleteAnimation: .automatic)
    
    static func dataSource() -> DataSource {
        
        let configureCell: DataSource.ConfigureCell = { (ds, cv, ip, item) -> UICollectionViewCell in
            let reuseId = CrewCollectionViewCell.reuseId
            
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: reuseId, for: ip) as? CrewCollectionViewCell
            else { return UICollectionViewCell() }
            
            cell.viewModel = item
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
        }
        
        return DataSource(
            animationConfiguration: animationConfiguration,
            configureCell: configureCell)
        
    }
    
}
