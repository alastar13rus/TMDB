//
//  SearchTableViewDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 25.05.2021.
//

import Foundation
import RxDataSources

struct SearchTableViewDataSource: DataSourceProtocol {
    
    typealias DataSource = RxTableViewSectionedAnimatedDataSource<SearchQuickRequestCellModelMultipleSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .automatic, deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            switch dataSource[indexPath] {
            case .categoryList(let vm):
                let cell = SearchCategoryListTableViewCell()
                cell.viewModel = vm
                return cell
            case .peopleList(let vm):
                let cell = PeopleShortListTableViewCell()
                cell.viewModel = vm
                return cell
            case .media(let vm):
                let cell = MediaTableViewCell()
                cell.viewModel = vm
                return cell
            case .people(let vm):
                let cell = PeopleTableViewCell()
                cell.viewModel = vm
                return cell
            }
        }
        
        let titleForHeaderInSection: DataSource.TitleForHeaderInSection = { (dataSource, section) -> String? in
            switch dataSource[section] {
            case .categoryListSection(let title, _): return title
            case .peopleListSection(let title, _): return title
            case .resultSection(let title, _): return title
            }
        }
        
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell, titleForHeaderInSection: titleForHeaderInSection)
    }
}
