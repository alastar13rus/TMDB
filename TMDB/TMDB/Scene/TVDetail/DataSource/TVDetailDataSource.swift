//
//  TVDetailDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 09.04.2021.
//

import Foundation
import RxDataSources

struct TVDetailDataSource {
    
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
                let cell = TVOverviewCell()
                cell.viewModel = vm
                return cell
                
            case .tvInfo(let vm):
                let cell = TVInfoCell()
                cell.viewModel = vm
                return cell
                
            case .tvRuntime(let vm):
                let cell = TVRuntimeCell()
                cell.viewModel = vm
                return cell
                
            case .tvGenres(let vm):
                let cell = TVGenresCell()
                cell.viewModel = vm
                return cell
                
            case .tvCreators(let vm):
                let cell = TVCreatorWithPhotoCell()
                cell.viewModel = vm
                return cell
                
            case .tvStatus(let vm):
                let cell = TVStatusCell()
                cell.viewModel = vm
                return cell
            
            case .tvCastList(let vm):
                let cell = TVCastListCell()
                cell.viewModel = vm
                return cell
            }
        }
        
        let titleForHeaderInSection: DataSource.TitleForHeaderInSection = { (dataSource, section) -> String? in
            switch dataSource[section] {
            case .tvRuntimeSection(let title, _),
                 .tvGenresSection(let title, _),
                 .tvCreatorsSection(let title, _),
                 .tvCastListSection(let title, _),
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
//            titleForFooterInSection: <#T##DataSource.TitleForFooterInSection##DataSource.TitleForFooterInSection##(TableViewSectionedDataSource<TVDetailCellViewModelMultipleSection>, Int) -> String?#>
        )
        
    }
    
    
}
