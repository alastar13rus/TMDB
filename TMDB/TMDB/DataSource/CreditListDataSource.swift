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
                let cell = CreditCastCell()
                cell.viewModel = vm
                return cell
            case .tvAggregateCast(let vm):
                let cell = CreditTVAggregateCastCell()
                cell.viewModel = vm
                return cell
            case .crew(let vm):
                let cell = CreditCrewCell()
                cell.viewModel = vm
                return cell
            case .tvAggregateCrew(let vm):
                let cell = CreditTVAggregateCrewCell()
                cell.viewModel = vm
                return cell
            }
        }
        
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
    }
    
}
