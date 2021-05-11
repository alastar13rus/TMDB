//
//  TVSeasonDetailDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 04.05.2021.
//

import Foundation
import RxDataSources

struct TVSeasonDetailDataSource: DataSourceProtocol {
    
    typealias DataSource = RxTableViewSectionedAnimatedDataSource<TVSeasonDetailCellViewModelMultipleSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(
            insertAnimation: .automatic,
            reloadAnimation: .automatic,
            deleteAnimation: .automatic
        )
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            
            switch dataSource[indexPath] {
            
            case .tvSeasonPosterWrapper(let vm):
                let cell = TVSeasonPosterWrapperTableViewCell()
                cell.viewModel = vm
                return cell
                
            case .tvSeasonImageList(let vm):
                let cell = ImageListTableViewCell(withImageType: .backdrop(size: .small))
                cell.viewModel = vm
                return cell
                
            case .tvSeasonTrailerButton(let vm):
                let cell = ButtonTableViewCell()
                cell.viewModel = vm
                return cell
                
            case .tvSeasonOverview(let vm):
                let cell = TVSeasonOverviewTableViewCell()
                cell.viewModel = vm
                return cell
                
            case .tvEpisodeShortList(let vm):
                let cell = TVEpisodeShortListTableViewCell()
                cell.viewModel = vm
                return cell
            
            case .tvSeasonCrewShortList(vm: let vm):
                let cell = CrewShortListTableViewCell()
                cell.viewModel = vm
                return cell
                
            case .tvSeasonCastShortList(vm: let vm):
                let cell = CastShortListTableViewCell()
                cell.viewModel = vm
                return cell
            }
        }
        
        let titleForHeaderInSection: DataSource.TitleForHeaderInSection = { (dataSource, section) -> String? in
            return nil
        }
        
        return DataSource(
            animationConfiguration: animationConfiguration,
            configureCell: configureCell,
            titleForHeaderInSection: titleForHeaderInSection
        )
        
    }
    
    
}
