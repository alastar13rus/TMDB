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
    
    private static let animationConfiguration = AnimationConfiguration(
        insertAnimation: .automatic,
        reloadAnimation: .automatic,
        deleteAnimation: .automatic)
    
    private static let configureCell: DataSource.ConfigureCell = { (ds, tv, ip, item) -> UITableViewCell in
        switch ds[ip] {
        case .season(let vm):
            let cell = TVSeasonTableViewCell()
            cell.viewModel = vm
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
        default: return UITableViewCell()
        }
       
    }
    
    static func dataSource() -> DataSource {
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
    }
    
}
