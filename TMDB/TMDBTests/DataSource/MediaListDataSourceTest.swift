//
//  MediaListDataSourceTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 15.04.2021.
//

import XCTest
@testable import TMDB

class MediaListDataSourceTest: XCTestCase {
    
    func test_dataSourceWithMovies() {
        
        let coordinator = MovieFlowCoordinator(navigationController: UINavigationController())
        let (_, viewModel, controller) = coordinator.factory(vmType: MediaListViewModel.self, vcType: MediaListViewController.self)
        
        let items: [MediaCellViewModelMultipleSection.SectionItem] = [
            
            .movie(vm: MediaCellViewModel(MovieModel(posterPath: nil, adult: false, overview: "", releaseDate: "", genreIds: [], id: 1, originalTitle: "", originalLanguage: "", title: "Title 1", backdropPath: nil, popularity: 0, voteCount: 0, video: false, voteAverage: 0))),
            
            .movie(vm: MediaCellViewModel(MovieModel(posterPath: nil, adult: false, overview: "", releaseDate: "", genreIds: [], id: 2, originalTitle: "", originalLanguage: "", title: "Title 2", backdropPath: nil, popularity: 0, voteCount: 0, video: false, voteAverage: 0))),
            
        ]
        
        XCTAssertEqual(viewModel.screen, .movie(MediaListTableViewDataSource.Screen.movieListInfo))
        
        viewModel.output.sectionedItems.accept([
            .movieSection(title: "Фильмы", items: items)
        ])
        
        switch controller.mediaListDataSource[0].items.first {
        case .movie(let vm):
            XCTAssertEqual(vm.title, "Title 1")
        default: break
        }
        
        switch controller.mediaListDataSource[0].items[1] {
        case .movie(let vm):
            XCTAssertEqual(vm.title, "Title 2")
        default: break
        }
        
        
    }
    
    func test_dataSourceWithTV() {
        
        let coordinator = TVFlowCoordinator(navigationController: UINavigationController())
        let (_, viewModel, controller) = coordinator.factory(vmType: MediaListViewModel.self, vcType: MediaListViewController.self)
        
        let items: [MediaCellViewModelMultipleSection.SectionItem] = [
            
            .tv(vm: MediaCellViewModel(TVModel(firstAirDate: nil, originCountry: [], name: "Title 3", originalName: "", id: 3, popularity: 0, voteCount: 0, posterPath: nil, backdropPath: nil, originalLanguage: "", genreIds: [], voteAverage: 0, overview: "")))
            
        ]
        
        XCTAssertEqual(viewModel.screen, .tv(MediaListTableViewDataSource.Screen.tvListInfo))
        
        viewModel.output.sectionedItems.accept([
            .tvSection(title: "Сериалы", items: items)
        ])
        
        switch controller.mediaListDataSource[0].items.first {
        case .tv(let vm):
            XCTAssertEqual(vm.title, "Title 3")
        default: break
        }
        
        
    }

}
