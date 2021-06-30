//
//  CreditShortListDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import Foundation
import RxDataSources

struct CreditShortListDataSource: DataSourceProtocol {
    
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<CreditCellViewModelMultipleSection>
    
    private static let animationConfiguration = AnimationConfiguration(
        insertAnimation: .automatic,
        reloadAnimation: .automatic,
        deleteAnimation: .automatic)
    
    private static let configureCell: DataSource.ConfigureCell = { (ds, cv, ip, item) -> UICollectionViewCell in
        
        switch ds[ip] {
            
        case .cast(let vm):
            let reuseId = CastCollectionViewCell.reuseId
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: reuseId, for: ip) as? CastCollectionViewCell
            else { return UICollectionViewCell() }
            
            cell.viewModel = vm
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
            
        case .aggregateCast(let vm):
            let reuseId = TVAggregateCastCollectionViewCell.reuseId
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: reuseId, for: ip) as? TVAggregateCastCollectionViewCell
            else { return UICollectionViewCell() }
            
            cell.viewModel = vm
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
            
        case .crew(let vm):
            let reuseId = CrewCollectionViewCell.reuseId
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: reuseId, for: ip) as? CrewCollectionViewCell
            else { return UICollectionViewCell() }
            
            cell.viewModel = vm
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
            
        case .aggregateCrew(let vm):
            let reuseId = TVAggregateCrewCollectionViewCell.reuseId
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: reuseId, for: ip) as? TVAggregateCrewCollectionViewCell
            else { return UICollectionViewCell() }
            
            cell.viewModel = vm
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
            
        case .showMore(let vm):
            let reuseId = ShowMoreCell.reuseId
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: reuseId, for: ip) as? ShowMoreCell
            else { return UICollectionViewCell() }
            
            cell.viewModel = vm
            return cell
        }
    }
    
    static func dataSource() -> DataSource {
        
        return DataSource(
            animationConfiguration: animationConfiguration,
            configureCell: configureCell)
        
    }
    
}
