//
//  MovieDetailDataSourceTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 15.04.2021.
//

import XCTest
@testable import TMDB

class MovieDetailDataSourceTest: XCTestCase {
    
    func test_dataSource() {
        
        let coordinator = MovieListCoordinator(navigationController: UINavigationController())
        let (_, viewModel, controller) = coordinator.factory(with: "761053", vmType: MovieDetailViewModel.self, vcType: MovieDetailViewController.self)
        
        let movieDetailModel = MovieDetailModel(adult: false, backdropPath: nil, budget: 0, genres: [], homepage: "", id: 761053, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: nil, productionCountries: [], productionCompanies: [], releaseDate: nil, revenue: 0, runtime: 0, spokenLanguages: [], status: "", tagline: "", title: "Title 1", voteAverage: 0, voteCount: 0, video: false, credits: nil)
        
        let movieDetailModel2 = MovieDetailModel(adult: false, backdropPath: nil, budget: 0, genres: [], homepage: "", id: 761054, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: nil, productionCountries: [], productionCompanies: [], releaseDate: nil, revenue: 0, runtime: 0, spokenLanguages: [], status: "", tagline: "", title: "Title 2", voteAverage: 0, voteCount: 0, video: false, credits: nil)
        
        let item1: MovieDetailCellViewModelMultipleSection.SectionItem = .moviePosterWrapper(vm: MoviePosterWrapperCellViewModel(movieDetailModel))
        
        let item2: MovieDetailCellViewModelMultipleSection.SectionItem = .movieOverview(vm: MediaOverviewCellViewModel(movieDetailModel2))
        
        viewModel.output.sectionedItems.accept([
            .moviePosterWrapperSection(title: "Poster", items: [item1]),
            .moviePosterWrapperSection(title: "Overview", items: [item2])
        ])
        
        XCTAssertEqual(controller.dataSource[0].items.first?.identity, "761053")
        XCTAssertEqual(controller.dataSource[1].items.first?.identity, "761054")

        
    }

    
}
