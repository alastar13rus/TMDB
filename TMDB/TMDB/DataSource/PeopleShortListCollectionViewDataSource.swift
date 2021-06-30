//
//  PeopleShortListCollectionViewDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import Foundation
import RxDataSources

struct PeopleShortListCollectionViewDataSource: DataSourceProtocol {
    
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<PeopleShortListViewModelSection>
    
    private static let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic,
                                                                       reloadAnimation: .automatic,
                                                                       deleteAnimation: .automatic)
    
    private static let configureCell: DataSource.ConfigureCell = { (ds, cv, ip, item) -> UICollectionViewCell in
        guard let cell = cv.dequeueReusableCell(withReuseIdentifier: PeopleCollectionViewCell.reuseId, for: ip) as? PeopleCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.tag = ip.row
        cell.indexPath = ip
        cell.viewModel = item
        return cell
    }
    
    static func dataSource() -> DataSource {
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
    }
    
}
