//
//  TVEpisodeDetailDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.05.2021.
//

import Foundation
import RxDataSources

struct TVEpisodeDetailDataSource: DataSourceProtocol {
    
    typealias DataSource = RxTableViewSectionedAnimatedDataSource<TVEpisodeDetailCellViewModelMultipleSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(
            insertAnimation: .automatic,
            reloadAnimation: .automatic,
            deleteAnimation: .automatic
        )
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            
            switch dataSource[indexPath] {
            
            case .tvEpisodeStillWrapper(let vm):
                let cell = TVEpisodeStillWrapperTableViewCell()
                cell.viewModel = vm
                cell.indexPath = indexPath
                cell.tag = indexPath.row
                return cell
                
            case .tvEpisodeImageList(let vm):
                let cell = ImageListTableViewCell(withImageType: .still(size: .small))
                cell.viewModel = vm
                return cell
                
            case .tvEpisodeTrailerButton(let vm):
                let cell = ButtonTableViewCell()
                cell.viewModel = vm
                return cell
                
            case .tvEpisodeOverview(let vm):
                let cell = TVEpisodeOverviewTableViewCell()
                cell.viewModel = vm
                return cell
            
            case .tvEpisodeCrewShortList(vm: let vm):
                let cell = CrewShortListTableViewCell()
                cell.viewModel = vm
                return cell
                
            case .tvEpisodeCastShortList(vm: let vm):
                let cell = CastShortListTableViewCell()
                cell.viewModel = vm
                return cell
                
            case .tvEpisodeGuestStarsShortList(vm: let vm):
                let cell = CastShortListTableViewCell()
                cell.viewModel = vm
                return cell
            }
        }
        
        let titleForHeaderInSection: DataSource.TitleForHeaderInSection = { (dataSource, section) -> String? in
            switch dataSource[section] {
            case .tvEpisodeCrewShortListSection(let title, _): return title
            case .tvEpisodeCastShortListSection(let title, _): return title
            case .tvEpisodeGuestStarsShortListSection(let title, _): return title
            default: return nil
            }
        }
        
        return DataSource(
            animationConfiguration: animationConfiguration,
            configureCell: configureCell,
            titleForHeaderInSection: titleForHeaderInSection
        )
        
    }
    
    
}
