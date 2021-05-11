//
//  TVEpisodeListTableViewDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 05.05.2021.
//

import Foundation
import RxDataSources

struct TVEpisodeListTableViewDataSource: DataSourceProtocol {
    
    typealias DataSource = RxTableViewSectionedAnimatedDataSource<TVEpisodeCellViewModelMultipleSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(
            insertAnimation: .automatic,
            reloadAnimation: .automatic,
            deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            switch dataSource[indexPath] {
            case .episode(let vm):
                let cell = TVEpisodeTableViewCell()
                cell.viewModel = vm
                return cell
            default: return UITableViewCell()
            }
           
        }
        
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
        
    }
    
}
