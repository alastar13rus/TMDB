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
    
    private static let animationConfiguration = AnimationConfiguration(
        insertAnimation: .automatic,
        reloadAnimation: .automatic,
        deleteAnimation: .automatic
    )
    
    private static let configureCell: DataSource.ConfigureCell = { (ds, tv, ip, item) -> UITableViewCell in
            
            switch ds[ip] {
            
            case .tvSeasonPosterWrapper(let vm):
                let cell = TVSeasonPosterWrapperTableViewCell()
                cell.viewModel = vm
                cell.indexPath = ip
                cell.tag = ip.row
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
        
    private static let titleForHeaderInSection: DataSource.TitleForHeaderInSection = { (ds, section) -> String? in
            switch ds[section] {
            case .tvSeasonCrewShortListSection(let title, _): return title
            case .tvSeasonCastShortListSection(let title, _): return title
            default: return nil
            }
        }
    
    static func dataSource() -> DataSource {
        
        return DataSource(
            animationConfiguration: animationConfiguration,
            configureCell: configureCell,
            titleForHeaderInSection: titleForHeaderInSection
        )
        
    }
    
}
