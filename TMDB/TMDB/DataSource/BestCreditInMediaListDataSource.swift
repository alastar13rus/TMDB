//
//  BestCreditInMediaListDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.04.2021.
//

import Foundation
import RxDataSources

struct BestCreditInMediaListDataSource: DataSourceProtocol {
    
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<CreditInMediaCellViewModelMultipleSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .automatic, deleteAnimation: .automatic)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, collectionview, indexPath, item) -> UICollectionViewCell in
            switch dataSource[indexPath] {
            case .creditInMovie(let vm):
                guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: String(describing: CreditInMediaCell.self), for: indexPath) as? CreditInMediaCell else { return UICollectionViewCell() }
                cell.viewModel = vm
                return cell
            case .creditInTV(let vm):
                guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: String(describing: CreditInMediaCell.self), for: indexPath) as? CreditInMediaCell else { return UICollectionViewCell() }
                cell.viewModel = vm
                return cell
            }
        }
        
        let configureSupplementaryView: DataSource.ConfigureSupplementaryView = { (dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            var title = ""
            switch dataSource[indexPath] {
            case .creditInMovie: title = "Фильмы"
            case .creditInTV: title = "Сериалы"
            }
            
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: ReusableHeaderView.self), for: indexPath) as! ReusableHeaderView
                view.configure(withTitle: title)
                return view
            default:
                return UICollectionReusableView()
            }
        }
        
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell, configureSupplementaryView: configureSupplementaryView)
    }
    
}
