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
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CreditCastCell.self), for: indexPath) as? CreditCastCell else { return UITableViewCell() }
                cell.viewModel = vm
                return cell
            case .crew(let vm):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CreditCrewCell.self), for: indexPath) as? CreditCrewCell else { return UITableViewCell() }
                cell.viewModel = vm
                return cell
            }
        }
        
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
    }
    
}
