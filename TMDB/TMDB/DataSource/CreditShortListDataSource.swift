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
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(
            insertAnimation: .automatic,
            reloadAnimation: .automatic,
            deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
            switch dataSource[indexPath] {
            case .cast(let vm):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CastCollectionViewCell.self), for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell() }
                cell.viewModel = vm
                cell.indexPath = indexPath
                cell.tag = indexPath.row
                return cell
            case .aggregateCast(let vm):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TVAggregateCastCollectionViewCell.self), for: indexPath) as? TVAggregateCastCollectionViewCell else { return UICollectionViewCell() }
                cell.viewModel = vm
                cell.indexPath = indexPath
                cell.tag = indexPath.row
                return cell
            case .crew(let vm):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CrewCollectionViewCell.self), for: indexPath) as? CrewCollectionViewCell else { return UICollectionViewCell() }
                cell.viewModel = vm
                cell.indexPath = indexPath
                cell.tag = indexPath.row
                return cell
            case .aggregateCrew(let vm):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TVAggregateCrewCollectionViewCell.self), for: indexPath) as? TVAggregateCrewCollectionViewCell else { return UICollectionViewCell() }
                cell.viewModel = vm
                cell.indexPath = indexPath
                cell.tag = indexPath.row
                return cell
            case .showMore(let vm):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ShowMoreCell.self), for: indexPath) as? ShowMoreCell else { return UICollectionViewCell() }
                cell.viewModel = vm
                return cell
            }
        }
        
        return DataSource(
            animationConfiguration: animationConfiguration,
            configureCell: configureCell)
        
    }
    
}
