//
//  FavoriteListTableViewDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 07.06.2021.
//

import Foundation
import RxDataSources

struct FavoriteListTableViewDataSource: DataSourceProtocol {
    
    typealias DataSource = RxTableViewSectionedAnimatedDataSource<FavoriteCellViewModelMultipleSection>
    
    private static let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic,
                                                                       reloadAnimation: .automatic,
                                                                       deleteAnimation: .automatic)
    
    private static let configureCell: DataSource.ConfigureCell = { (ds, tv, ip, item) -> UITableViewCell in
        switch ds[ip] {
        case .media(let vm):
            let cell = MediaTableViewCell()
            cell.viewModel = vm
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
        case .people(let vm):
            let cell = PeopleTableViewCell()
            cell.viewModel = vm
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
        }
    }
    
    private static let titleForHeaderInSection: DataSource.TitleForHeaderInSection = { (ds, section) -> String? in
        switch ds[section] {
        case .mediaSection(let title, _): return title
        case .peopleSection(let title, _): return title
        }
    }
    
    private static let canEditRowAtIndexPath: DataSource.CanEditRowAtIndexPath = { (ds, indexPath) -> Bool in
        return true
    }
    
    static func dataSource() -> DataSource {
        
        return DataSource(animationConfiguration: animationConfiguration,
                          configureCell: configureCell,
                          titleForHeaderInSection: titleForHeaderInSection,
                          canEditRowAtIndexPath: canEditRowAtIndexPath)
    }
}
