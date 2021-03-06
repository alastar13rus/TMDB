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
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(
            insertAnimation: .automatic,
            reloadAnimation: .automatic,
            deleteAnimation: .automatic
        )
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            
            switch dataSource[indexPath] {
            
            case .moviePosterWrapper(let vm):
                let cell = MoviePosterWrapperTableViewCell()
                cell.viewModel = vm
                cell.indexPath = indexPath
                cell.tag = indexPath.row
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
        
        let titleForHeaderInSection: DataSource.TitleForHeaderInSection = { (dataSource, section) -> String? in
            switch dataSource[section] {
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
        
        return DataSource(
            animationConfiguration: animationConfiguration,
            configureCell: configureCell,
            titleForHeaderInSection: titleForHeaderInSection
        )
        
    }
    
    
}
