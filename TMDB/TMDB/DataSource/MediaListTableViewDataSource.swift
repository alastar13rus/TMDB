//
//  MediaListTableViewDataSource.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 17.03.2021.
//

import Foundation
import RxDataSources

struct MediaListTableViewDataSource {
    
    typealias DataSource = RxTableViewSectionedAnimatedDataSource<MediaCellViewModelMultipleSection>
    
    private static let animationConfiguration = AnimationConfiguration(
        insertAnimation: .left,
        reloadAnimation: .left,
        deleteAnimation: .right)
    
    private static let configureCell: DataSource.ConfigureCell = { (ds, tv, ip, item) -> UITableViewCell in
        switch item {
        case .movie(let vm), .tv(let vm) :
            let cell = MediaTableViewCell()
            cell.viewModel = vm
            cell.indexPath = ip
            cell.tag = ip.row
            return cell
        }
    }
    
    static func dataSource() -> DataSource {
        return DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
    }
    
    struct MovieListInfo {
        let title = "Рейтинг фильмов"
        let categories = ["ТОП рейтинга", "Популярные", "Свежие", "Ожидаемые"]
    }
    
    struct TVListInfo {
        let title = "Рейтинг сериалов"
        let categories = ["ТОП рейтинга", "Популярные", "Свежие", "Ожидаемые"]
    }
    
    enum Screen: Equatable {
        
        case movie(MovieListInfo)
        case tv(TVListInfo)
        
        static let movieListInfo = MovieListInfo()
        static let tvListInfo = TVListInfo()
    
        static func == (lhs: MediaListTableViewDataSource.Screen, rhs: MediaListTableViewDataSource.Screen) -> Bool {
            switch (lhs, rhs) {
            case (.movie(let lhsInfo), .movie(let rhsInfo)):
                return lhsInfo.title == rhsInfo.title && lhsInfo.categories == rhsInfo.categories
            case (.tv(let lhsInfo), .tv(let rhsInfo)):
                return lhsInfo.title == rhsInfo.title && lhsInfo.categories == rhsInfo.categories
            case (.movie, .tv):
                return false
            case (.tv, .movie):
                return false
            }
        }
    }
}
