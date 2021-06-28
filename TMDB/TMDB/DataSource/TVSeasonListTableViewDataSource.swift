//
//  TVSeasonListTableViewDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 01.05.2021.
//

import Foundation
import RxDataSources

struct TVSeasonListTableViewDataSource: DataSourceProtocol {
    
    typealias DataSource = RxTableViewSectionedAnimatedDataSource<TVSeasonCellViewModelMultipleSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(
            insertAnimation: .automatic,
            reloadAnimation: .automatic,
            deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            switch dataSource[indexPath] {
            case .season(let vm):
                let cell = TVSeasonTableViewCell()
                cell.viewModel = vm
                cell.indexPath = indexPath
                cell.tag = indexPath.row
                return cell
            default: return UITableViewCell()
            }
           
        }
        
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
        
    }
    
}
