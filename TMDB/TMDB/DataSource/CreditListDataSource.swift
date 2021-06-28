//
//  CreditListDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.04.2021.
//

import Foundation
import RxDataSources

struct CreditListDataSource {
    
    typealias DataSource = RxTableViewSectionedAnimatedDataSource<CreditListViewModelMultipleSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .automatic, deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            switch dataSource[indexPath] {
            case .cast(let vm):
                let cell = CreditCastTableViewCell()
                cell.viewModel = vm
                cell.indexPath = indexPath
                cell.tag = indexPath.row
                return cell
            case .tvAggregateCast(let vm):
                let cell = CreditTVAggregateCastTableViewCell()
                cell.viewModel = vm
                cell.indexPath = indexPath
                cell.tag = indexPath.row
                return cell
            case .crew(let vm):
                let cell = CreditCrewTableViewCell()
                cell.viewModel = vm
                cell.indexPath = indexPath
                cell.tag = indexPath.row
                return cell
            case .tvAggregateCrew(let vm):
                let cell = CreditTVAggregateCrewTableViewCell()
                cell.viewModel = vm
                cell.indexPath = indexPath
                cell.tag = indexPath.row
                return cell
            }
        }
        
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
    }
    
}
