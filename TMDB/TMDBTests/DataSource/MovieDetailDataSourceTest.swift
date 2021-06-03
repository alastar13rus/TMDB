//
//  MovieDetailDataSourceTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 15.04.2021.
//

import XCTest
@testable import TMDB
@testable import Domain
@testable import NetworkPlatform

class MovieDetailDataSourceTest: XCTestCase {
    
    func test_dataSource() {
        
        let container = AppDIContainer.shared
        let coordinator = MovieFlowCoordinator(navigationController: UINavigationController(), container: container)
        let (viewController, viewModel, _) = container.resolve(Typealias.MovieDetailBundle.self, arguments: coordinator, "761053")!
        
        let movieDetailModel = MovieDetailModel(adult: false, backdropPath: nil, budget: 0, genres: [], homepage: "", id: 761053, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: nil, productionCountries: [], productionCompanies: [], releaseDate: nil, revenue: 0, runtime: 0, spokenLanguages: [], status: "", tagline: "", title: "Title 1", voteAverage: 0, voteCount: 0, video: false, credits: nil, recommendations: nil, similar: nil, images: nil, videos: nil)
        
        let movieDetailModel2 = MovieDetailModel(adult: false, backdropPath: nil, budget: 0, genres: [], homepage: "", id: 761054, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: nil, productionCountries: [], productionCompanies: [], releaseDate: nil, revenue: 0, runtime: 0, spokenLanguages: [], status: "", tagline: "", title: "Title 2", voteAverage: 0, voteCount: 0, video: false, credits: nil, recommendations: nil, similar: nil, images: nil, videos: nil)
        
        let item1: MovieDetailCellViewModelMultipleSection.SectionItem = .moviePosterWrapper(vm: MoviePosterWrapperCellViewModel(movieDetailModel))
        
        let item2: MovieDetailCellViewModelMultipleSection.SectionItem = .movieOverview(vm: MediaOverviewCellViewModel(movieDetailModel2))
        
        viewModel.output.sectionedItems.accept([
            .moviePosterWrapperSection(title: "Poster", items: [item1]),
            .moviePosterWrapperSection(title: "Overview", items: [item2])
        ])
        
        XCTAssertEqual(viewController.dataSource[0].items.first?.identity, "761053")
        XCTAssertEqual(viewController.dataSource[1].items.first?.identity, "761054")

        
    }

    
}
