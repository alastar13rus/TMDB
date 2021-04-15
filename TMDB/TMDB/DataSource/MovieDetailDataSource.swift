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
                let cell = MoviePosterWrapperCell()
                cell.viewModel = vm
                return cell
                
            case .movieOverview(let vm):
                let cell = MediaOverviewCell()
                cell.viewModel = vm
                return cell
                
            case .movieRuntime(let vm):
                let cell = MovieRuntimeCell()
                cell.viewModel = vm
                return cell
                
            case .movieGenres(let vm):
                let cell = GenresCell()
                cell.viewModel = vm
                return cell
                
            case .movieStatus(let vm):
                let cell = MediaStatusCell()
                cell.viewModel = vm
                return cell
                
            case .movieCastList(let vm):
                let cell = CastListCell()
                cell.viewModel = vm
                return cell
                
            case .movieCrewList(let vm):
                let cell = CrewListCell()
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
                 .movieStatusSection(let title, _):
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
