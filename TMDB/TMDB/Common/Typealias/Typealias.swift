//
//  Typealias.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 23.05.2021.
//

import Foundation

struct Typealias {
    typealias MediaListBundle = (MediaListViewController, MediaListViewModel, NavigationCoordinator)
    typealias MovieDetailBundle = (MovieDetailViewController, MovieDetailViewModel, MovieFlowCoordinator)
    typealias TVDetailBundle = (TVDetailViewController, TVDetailViewModel, TVFlowCoordinator)
    typealias TVSeasonListBundle = (TVSeasonListViewController, TVSeasonListViewModel, TVSeasonFlowCoordinator)
    typealias TVEpisodeListBundle = (TVEpisodeListViewController, TVEpisodeListViewModel, TVEpisodeFlowCoordinator)
    typealias TVSeasonDetailBundle = (TVSeasonDetailViewController, TVSeasonDetailViewModel, TVSeasonFlowCoordinator)
    typealias TVEpisodeDetailBundle = (TVEpisodeDetailViewController, TVEpisodeDetailViewModel, TVEpisodeFlowCoordinator)
    typealias MediaTrailerListBundle = (MediaTrailerListViewController, MediaTrailerListViewModel, NavigationCoordinator)
    typealias CreditListBundle = (CreditListViewController, CreditListViewModel, NavigationCoordinator)
    typealias PeopleDetailBundle = (PeopleDetailViewController, PeopleDetailViewModel, PeopleFlowCoordinator)
    
//    MARK: - Search
    typealias SearchBundle = (SearchViewController, SearchViewModel, SearchFlowCoordinator)
    typealias FilterOptionListMediaBundle = (FilterOptionListMediaViewController, FilterOptionListMediaViewModel, SearchFlowCoordinator)
    typealias MediaListByYearBundle = (MediaFilteredListViewController, MediaFilteredListViewModel, SearchFlowCoordinator)
    typealias MediaFilteredListBundle = (MediaFilteredListViewController, MediaFilteredListViewModel, SearchFlowCoordinator)
    
//    MARK: - Search
        typealias FavoriteBundle = (FavoriteListViewController, FavoriteListViewModel, FavoriteFlowCoordinator)
    
    
}
