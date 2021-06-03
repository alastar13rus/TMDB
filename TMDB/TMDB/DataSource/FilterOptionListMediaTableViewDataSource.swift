//
//  FilterOptionListMediaTableViewDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.05.2021.
//

import Foundation
import RxDataSources

struct FilterOptionListMediaTableViewDataSource: DataSourceProtocol {
    
    typealias DataSource = RxTableViewSectionedAnimatedDataSource<FilterOptionListMediaModelMultipleSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .automatic, deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            switch dataSource[indexPath] {
            case .mediaByYear(let vm):
                let cell = FilterOptionMediaByYearTableViewCell()
                cell.viewModel = vm
                return cell
            case .mediaByGenre(let vm):
                let cell = FilterOptionMediaByGenreTableViewCell()
                cell.viewModel = vm
                return cell
            }
            
        }
        
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
        
    }
    
}
