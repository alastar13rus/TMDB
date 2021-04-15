//
//  MediaListDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 17.03.2021.
//

import Foundation
import RxDataSources

struct MediaListDataSource {
    
    typealias DataSource = RxTableViewSectionedAnimatedDataSource<MediaCellViewModelMultipleSection>
    
    static func dataSource() -> DataSource {
        
        let animationConfiguration = AnimationConfiguration(
            insertAnimation: .left,
            reloadAnimation: .left,
            deleteAnimation: .right)
        
        let configureCell: DataSource.ConfigureCell = { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            switch item {
            case .movie(let vm), .tv(let vm) :
                let cell = MediaTableViewCell()
                cell.viewModel = vm
                return cell
            }
        }
        
        let dataSource = RxTableViewSectionedAnimatedDataSource(
            animationConfiguration: animationConfiguration,
            configureCell: configureCell)
        
        return dataSource
        
    }
    
    enum Screen: Equatable {
        
        case movie(MovieListInfo)
        case tv(TVListInfo)
        
        
        struct MovieListInfo {
            let title = "Рейтинг фильмов"
            let categories = ["ТОП рейтинга", "Популярные", "Свежие", "Ожидаемые"]
        }
        
        struct TVListInfo {
            let title = "Рейтинг сериалов"
            let categories = ["ТОП рейтинга", "Популярные", "Свежие", "Ожидаемые"]
        }
        
        static let movieListInfo = MovieListInfo()
        static let tvListInfo = TVListInfo()
    
        static func == (lhs: MediaListDataSource.Screen, rhs: MediaListDataSource.Screen) -> Bool {
            switch (lhs, rhs) {
            case (.movie(let lhsInfo), .movie(let rhsInfo)):
                return lhsInfo.title == rhsInfo.title && lhsInfo.categories == rhsInfo.categories
            case (.tv(let lhsInfo), .tv(let rhsInfo)):
                return lhsInfo.title == rhsInfo.title && lhsInfo.categories == rhsInfo.categories
            case (.movie(_), .tv(_)):
                return false
            case (.tv(_), .movie(_)):
                return false
            }
        }
        
    }
    
}
