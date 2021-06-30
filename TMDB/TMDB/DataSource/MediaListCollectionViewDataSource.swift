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
    
    private static let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic,
                                                                       reloadAnimation: .automatic,
                                                                       deleteAnimation: .automatic)
    
    private static let configureCell: DataSource.ConfigureCell = { (ds, cv, ip, item) -> UICollectionViewCell in
        switch ds[ip] {
        case .movie(let vm):
            let reuseId = MediaCollectionViewCell.reuseId
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: MediaCollectionViewCell.reuseId, for: ip) as? MediaCollectionViewCell
            else { return UICollectionViewCell() }
            
            cell.viewModel = vm
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
            
        case .tv(let vm):
            let reuseId = MediaCollectionViewCell.reuseId
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: reuseId, for: ip) as? MediaCollectionViewCell
            else { return UICollectionViewCell() }
            
            cell.viewModel = vm
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
        }
    }
    
    static func dataSource() -> DataSource {
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
    }
    
}
