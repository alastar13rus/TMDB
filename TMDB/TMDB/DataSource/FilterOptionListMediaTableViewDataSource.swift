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
    
    private static let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic,
                                                                       reloadAnimation: .automatic,
                                                                       deleteAnimation: .automatic)
    
    private static let configureCell: DataSource.ConfigureCell = { (ds, tv, ip, item) -> UITableViewCell in
        switch ds[ip] {
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
    
    static func dataSource() -> DataSource {
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
    }
    
}
