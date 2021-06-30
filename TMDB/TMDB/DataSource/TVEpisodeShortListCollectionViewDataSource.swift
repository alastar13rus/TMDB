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
    
    private static let animationConfiguration = AnimationConfiguration(
        insertAnimation: .automatic,
        reloadAnimation: .automatic,
        deleteAnimation: .automatic)
    
    private static let configureCell: DataSource.ConfigureCell = { (ds, cv, ip, item) -> UICollectionViewCell in
        switch ds[ip] {
            
        case .episode(let vm):
            let reuseId = TVEpisodeCollectionViewCell.reuseId
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: reuseId, for: ip) as? TVEpisodeCollectionViewCell
            else { return UICollectionViewCell() }
            
            cell.viewModel = vm
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
            
        case .showMore(let vm):
            let reuseId = ShowMoreCell.reuseId
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: reuseId, for: ip) as? ShowMoreCell
            else { return UICollectionViewCell() }
            
            cell.viewModel = vm
            return cell
        }
    }
    
    static func dataSource() -> DataSource {
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
    }
}
