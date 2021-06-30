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
    
    private static let animationConfiguration = AnimationConfiguration(
        insertAnimation: .automatic,
        reloadAnimation: .automatic,
        deleteAnimation: .automatic)
    
    private static let configureCell: DataSource.ConfigureCell = { (ds, cv, ip, item) -> UICollectionViewCell in
        
        switch ds[ip] {
            
        case .season(let vm):
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: TVSeasonCollectionViewCell.reuseId,
                                                    for: ip) as? TVSeasonCollectionViewCell
            else { return UICollectionViewCell() }
            cell.viewModel = vm
            cell.indexPath = ip
            cell.tag = ip.row
            cell.tag = ip.row
            return cell
            
        case .showMore(let vm):
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: ShowMoreCell.reuseId,
                                                    for: ip) as? ShowMoreCell
            else { return UICollectionViewCell() }
            cell.viewModel = vm
            return cell
        }
    }
    
    static func dataSource() -> DataSource {
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
    }
    
}
