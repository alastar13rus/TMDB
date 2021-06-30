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
    
    private static let animationConfiguration = AnimationConfiguration(
        insertAnimation: .automatic,
        reloadAnimation: .automatic,
        deleteAnimation: .automatic
    )
    
    private static let configureCell: DataSource.ConfigureCell = { (ds, tv, ip, item) -> UITableViewCell in
        
        switch ds[ip] {
        
        case .tvPosterWrapper(let vm):
            let cell = TVPosterWrapperTableViewCell()
            cell.viewModel = vm
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
            
        case .tvImageList(let vm):
            let cell = ImageListTableViewCell(withImageType: .backdrop(size: .small))
            cell.viewModel = vm
            return cell
            
        case .tvTrailerButton(let vm):
            let cell = ButtonTableViewCell()
            cell.viewModel = vm
            return cell
            
        case .tvOverview(let vm):
            let cell = MediaOverviewTableViewCell()
            cell.viewModel = vm
            return cell
            
        case .tvRuntime(let vm):
            let cell = TVRuntimeTableViewCell()
            cell.viewModel = vm
            return cell
            
        case .tvGenres(let vm):
            let cell = GenresTableViewCell()
            cell.viewModel = vm
            return cell
            
        case .tvStatus(let vm):
            let cell = MediaStatusTableViewCell()
            cell.viewModel = vm
            return cell
            
        case .tvCastShortList(let vm):
            let cell = CastShortListTableViewCell()
            cell.viewModel = vm
            return cell
            
        case .tvCrewShortList(let vm):
            let cell = CrewShortListTableViewCell()
            cell.viewModel = vm
            return cell
            
        case .tvSeasonShortList(let vm):
            let cell = TVSeasonShortListTableViewCell()
            cell.viewModel = vm
            return cell
        
        case .tvCompilationList(let vm):
            let cell = MediaCompilationListTableViewCell()
            cell.viewModel = vm
            return cell
        }
    }
    
    private static let titleForHeaderInSection: DataSource.TitleForHeaderInSection = { (ds, section) -> String? in
        switch ds[section] {
        case .tvRuntimeSection(let title, _),
             .tvGenresSection(let title, _),
             .tvCastShortListSection(let title, _),
             .tvCrewShortListSection(let title, _),
             .tvStatusSection(let title, _),
             .tvCompilationListSection(let title, _):
            return title
        default:
            return nil
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
