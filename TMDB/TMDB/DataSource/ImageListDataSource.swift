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
    
    private static var animationConfiguration = AnimationConfiguration(insertAnimation: .automatic,
                                                               reloadAnimation: .automatic,
                                                               deleteAnimation: .automatic)
    
    private static let configureCell: DataSource.ConfigureCell = { (ds, cv, ip, item) -> UICollectionViewCell in
        guard let cell = cv.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseId, for: ip) as? ImageCell else { return UICollectionViewCell() }
        cell.viewModel = item
        cell.indexPath = ip
        cell.tag = ip.row
        return cell
    }
    
    static func dataSource() -> DataSource {
        DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
    }
    
}
