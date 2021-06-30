//
//  MovieDetailDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.04.2021.
//

import Foundation
import RxDataSources

struct MovieDetailDataSource: DataSourceProtocol {
    
    typealias DataSource = RxTableViewSectionedAnimatedDataSource<MovieDetailCellViewModelMultipleSection>
    
    private static let animationConfiguration = AnimationConfiguration(
        insertAnimation: .automatic,
        reloadAnimation: .automatic,
        deleteAnimation: .automatic)
    
    private static let configureCell: DataSource.ConfigureCell = { (ds, tv, ip, item) -> UITableViewCell in
        
        switch ds[ip] {
        
        case .moviePosterWrapper(let vm):
            let cell = MoviePosterWrapperTableViewCell()
            cell.viewModel = vm
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
            
        case .movieImageList(let vm):
            let cell = ImageListTableViewCell(withImageType: .backdrop(size: .small))
            cell.viewModel = vm
            return cell
            
        case .movieTrailerButton(let vm):
            let cell = ButtonTableViewCell()
            cell.viewModel = vm
            return cell
            
        case .movieOverview(let vm):
            let cell = MediaOverviewTableViewCell()
            cell.viewModel = vm
            return cell
            
        case .movieRuntime(let vm):
            let cell = MovieRuntimeTableViewCell()
            cell.viewModel = vm
            return cell
            
        case .movieGenres(let vm):
            let cell = GenresTableViewCell()
            cell.viewModel = vm
            return cell
            
        case .movieStatus(let vm):
            let cell = MediaStatusTableViewCell()
            cell.viewModel = vm
            return cell
            
        case .movieCastList(let vm):
            let cell = CastShortListTableViewCell()
            cell.viewModel = vm
            return cell
            
        case .movieCrewList(let vm):
            let cell = CrewShortListTableViewCell()
            cell.viewModel = vm
            return cell
            
        case .movieCompilationList(let vm):
            let cell = MediaCompilationListTableViewCell()
            cell.viewModel = vm
            return cell
        }
    }
    
    private static let titleForHeaderInSection: DataSource.TitleForHeaderInSection = { (ds, section) -> String? in
        switch ds[section] {
        case .movieRuntimeSection(let title, _),
             .movieGenresSection(let title, _),
             .movieCreatorsSection(let title, _),
             .movieCastListSection(let title, _),
             .movieCrewListSection(let title, _),
             .movieStatusSection(let title, _),
             .movieCompilationListSection(let title, _):
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
