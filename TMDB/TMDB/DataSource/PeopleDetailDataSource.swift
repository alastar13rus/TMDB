//
//  PeopleDetailDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.04.2021.
//

import Foundation
import RxDataSources

struct PeopleDetailDataSource: DataSourceProtocol {
    
    typealias DataSource = RxTableViewSectionedAnimatedDataSource<PeopleDetailCellViewModelMultipleSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .automatic, deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            switch dataSource[indexPath] {
            case .profileWrapper(let vm):
                let cell = PeopleProfileWrapperCell()
                cell.viewModel = vm
                return cell
            case .imageList(let vm):
                let cell = PeopleImageListTableViewCell()
                cell.viewModel = vm
                return cell
            case .bestMedia(let vm):
                let cell = PeopleBestMediaListTableViewCell()
                cell.viewModel = vm
                return cell
            case .bio(let vm):
                let cell = PeopleBioCell()
                cell.viewModel = vm
                return cell
            case .cast(let vm):
                let cell = CreditInMediaTableViewCell()
                cell.viewModel = vm
                return cell
            case .crew(let vm):
                let cell = CreditInMediaTableViewCell()
                cell.viewModel = vm
                return cell
            }
        }
        
        let titleForHeaderInSection: DataSource.TitleForHeaderInSection = { (dataSource, section) -> String? in
            switch dataSource[section] {
            case .profileWrapperSection: return nil
            case .imageListSection: return nil
            case .bioSection(let title, _): return title
            case .bestMediaSection(let title, _): return title
            case .castSection(let title, _): return title
            case .crewSection(let title, _): return title

                
            }
        }
        
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell, titleForHeaderInSection: titleForHeaderInSection)
        
    }
    
}
