//
//  MediaTrailerListDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation
import RxDataSources

struct MediaTrailerListDataSource: DataSourceProtocol {
    
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<MediaTrailerCellViewModelSection>
    
    private static let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic,
                                                        reloadAnimation: .automatic,
                                                        deleteAnimation: .automatic)
    
    private static let configureCell: DataSource.ConfigureCell = { (ds, cv, ip, item) -> UICollectionViewCell in
        let reuseId = MediaTrailerCollectionViewCell.reuseId
        guard let cell = cv.dequeueReusableCell(withReuseIdentifier: reuseId, for: ip) as? MediaTrailerCollectionViewCell
        else { return UICollectionViewCell() }
        cell.viewModel = item
        return cell
    }
    
    static func dataSource() -> DataSource {
        
        return DataSource(animationConfiguration: animationConfiguration,
                          configureCell: configureCell)
    }
    
}
