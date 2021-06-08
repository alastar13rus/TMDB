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
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .automatic, deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            switch dataSource[indexPath] {
            case .media(let vm):
                let cell = MediaTableViewCell()
                cell.viewModel = vm
                return cell
            case .people(let vm):
                let cell = PeopleTableViewCell()
                cell.viewModel = vm
                return cell
            }
        }
        
        let titleForHeaderInSection: DataSource.TitleForHeaderInSection = { (dataSource, section) -> String? in
            switch dataSource[section] {
            case .mediaSection(let title, _): return title
            case .peopleSection(let title, _): return title
            }
        }
        
        let canEditRowAtIndexPath: DataSource.CanEditRowAtIndexPath = { (dataSource, indexPath) -> Bool in
            return true
        }
        
        return DataSource(animationConfiguration: animationConfiguration,
                          configureCell: configureCell,
                          titleForHeaderInSection: titleForHeaderInSection,
                          canEditRowAtIndexPath: canEditRowAtIndexPath)
    }
}
