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
    
    private static let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic,
                                                                       reloadAnimation: .automatic,
                                                                       deleteAnimation: .automatic)
    
    private static let configureCell: DataSource.ConfigureCell = { (ds, tv, ip, item) -> UITableViewCell in
        switch ds[ip] {
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
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
        case .people(let vm):
            let cell = PeopleTableViewCell()
            cell.viewModel = vm
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
        }
    }
    
    private static let titleForHeaderInSection: DataSource.TitleForHeaderInSection = { (ds, section) -> String? in
        switch ds[section] {
        case .categoryListSection(let title, _): return title
        case .peopleListSection(let title, _): return title
        case .resultSection(let title, _): return title
        }
    }
    
    static func dataSource() -> DataSource {
        DataSource(animationConfiguration: animationConfiguration,
                   configureCell: configureCell,
                   titleForHeaderInSection: titleForHeaderInSection)
    }
}
