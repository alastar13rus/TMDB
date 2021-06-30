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
    
    private static let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic,
                                                                       reloadAnimation: .automatic,
                                                                       deleteAnimation: .automatic)
    
    private static let configureCell: DataSource.ConfigureCell = { (ds, tv, ip, item) -> UITableViewCell in
        switch ds[ip] {
        case .profileWrapper(let vm):
            let cell = PeopleProfileWrapperTableViewCell()
            cell.viewModel = vm
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
        case .imageList(let vm):
            let cell = ImageListTableViewCell(withImageType: .profile(size: .small))
            cell.viewModel = vm
            return cell
        case .bestMedia(let vm):
            let cell = PeopleBestMediaListTableViewCell()
            cell.viewModel = vm
            return cell
        case .bio(let vm):
            let cell = PeopleBioTableViewCell()
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
    
    private static let titleForHeaderInSection: DataSource.TitleForHeaderInSection = { (ds, section) -> String? in
        switch ds[section] {
        case .profileWrapperSection: return nil
        case .imageListSection: return nil
        case .bioSection(let title, _): return title
        case .bestMediaSection(let title, _): return title
        case .castSection(let title, _): return title
        case .crewSection(let title, _): return title
            
        }
    }
    
    static func dataSource() -> DataSource {
        
        return DataSource(animationConfiguration: animationConfiguration,
                          configureCell: configureCell,
                          titleForHeaderInSection: titleForHeaderInSection)
        
    }
    
}
