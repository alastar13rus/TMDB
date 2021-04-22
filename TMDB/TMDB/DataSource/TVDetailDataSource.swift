//
//  TVDetailDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 09.04.2021.
//

import Foundation
import RxDataSources

struct TVDetailDataSource: DataSourceProtocol {
    
    typealias DataSource = RxTableViewSectionedAnimatedDataSource<TVDetailCellViewModelMultipleSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(
            insertAnimation: .automatic,
            reloadAnimation: .automatic,
            deleteAnimation: .automatic
        )
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            
            switch dataSource[indexPath] {
            
            case .tvPosterWrapper(let vm):
                let cell = TVPosterWrapperCell()
                cell.viewModel = vm
                return cell
                
            case .tvOverview(let vm):
                let cell = MediaOverviewCell()
                cell.viewModel = vm
                return cell
                
            case .tvRuntime(let vm):
                let cell = TVRuntimeCell()
                cell.viewModel = vm
                return cell
                
            case .tvGenres(let vm):
                let cell = GenresCell()
                cell.viewModel = vm
                return cell
                
            case .tvStatus(let vm):
                let cell = MediaStatusCell()
                cell.viewModel = vm
                return cell
                
            case .tvCastList(let vm):
                let cell = CastShortListTableViewCell()
                cell.viewModel = vm
                return cell
                
            case .tvCrewList(let vm):
                let cell = CrewShortListTableViewCell()
                cell.viewModel = vm
                return cell
            }
        }
        
        let titleForHeaderInSection: DataSource.TitleForHeaderInSection = { (dataSource, section) -> String? in
            switch dataSource[section] {
            case .tvRuntimeSection(let title, _),
                 .tvGenresSection(let title, _),
                 .tvCastListSection(let title, _),
                 .tvCrewListSection(let title, _),
                 .tvStatusSection(let title, _):
                return title
            default:
                return nil
            }
        }
        
        return DataSource(
            animationConfiguration: animationConfiguration,
            configureCell: configureCell,
            titleForHeaderInSection: titleForHeaderInSection
        )
        
    }
    
    
}
