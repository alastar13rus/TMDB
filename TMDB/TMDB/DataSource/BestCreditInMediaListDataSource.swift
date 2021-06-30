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
    
    private static let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic,
                                                                       reloadAnimation: .automatic,
                                                                       deleteAnimation: .automatic)
    
    private static let configureSupplementaryView: DataSource.ConfigureSupplementaryView = { (ds, cv, kind, ip) -> UICollectionReusableView in
        var title = ""
        switch ds[ip] {
        case .creditInMovie: title = "Фильмы"
        case .creditInTV: title = "Сериалы"
        }
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            guard let view = cv.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ReusableHeaderView.reuseId,
                for: ip
            ) as? ReusableHeaderView else { return UICollectionReusableView() }
            
            view.configure(withTitle: title)
            return view
        default:
            return UICollectionReusableView()
        }
    }
    
    private static let configureCell: DataSource.ConfigureCell = { (ds, cv, ip, item) -> UICollectionViewCell in
        
        switch ds[ip] {
            
        case .creditInMovie(let vm):
            let reuseId = CreditInMediaCell.reuseId
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: reuseId, for: ip) as? CreditInMediaCell
            else { return UICollectionViewCell() }
            
            cell.viewModel = vm
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
            
        case .creditInTV(let vm):
            let reuseId = CreditInMediaCell.reuseId
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: reuseId, for: ip) as? CreditInMediaCell
            else { return UICollectionViewCell() }
            
            cell.viewModel = vm
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
        }
    }
    
    static func dataSource() -> DataSource {
        
        return DataSource(animationConfiguration: animationConfiguration,
                          configureCell: configureCell,
                          configureSupplementaryView: configureSupplementaryView)
    }
    
}
