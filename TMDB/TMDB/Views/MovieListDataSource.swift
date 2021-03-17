//
//  MovieListDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 17.03.2021.
//

import Foundation
import RxDataSources
 
struct MovieListDataSource {
    typealias DataSource = RxTableViewSectionedAnimatedDataSource<MovieCellViewModelSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(
            insertAnimation: .automatic,
            reloadAnimation: .automatic,
            deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            let cell = MovieTableViewCell()
            cell.viewModel = item
            return cell
        }
        
        let dataSource = RxTableViewSectionedAnimatedDataSource(
            animationConfiguration: animationConfiguration,
            configureCell: configureCell)
        
        return dataSource
        
    }
}
