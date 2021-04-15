//
//  TVDetailDataSourceTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 15.04.2021.
//

import XCTest
@testable import TMDB

class TVDetailDataSourceTest: XCTestCase {
    
    func test_dataSource() {
        
        let coordinator = TVListCoordinator(navigationController: UINavigationController())
        let (_, viewModel, controller) = coordinator.factory(with: "761053", vmType: TVDetailViewModel.self, vcType: TVDetailViewController.self)
        
        let tvDetailModel = TVDetailModel(backdropPath: nil, createdBy: [], episodeRunTime: [60], firstAirDate: "", genres: [], homepage: "", id: 123, inProduction: false, languages: [], lastAirDate: "", lastEpisodeToAir: TVEpisodeModel(), name: "Title 1", networks: [], numberOfEpisodes: 0, numberOfSeasons: 0, originCountry: [], originalLanguage: "", originalName: "", overview: "", popularity: 0, posterPath: nil, productionCompanies: [], seasons: [], status: "", tagline: "", type: "", voteAverage: 0, voteCount: 0, credits: nil)
        
        let tvDetailModel2 = TVDetailModel(backdropPath: nil, createdBy: [], episodeRunTime: [60], firstAirDate: "", genres: [], homepage: "", id: 456, inProduction: false, languages: [], lastAirDate: "", lastEpisodeToAir: TVEpisodeModel(), name: "Title 2", networks: [], numberOfEpisodes: 0, numberOfSeasons: 0, originCountry: [], originalLanguage: "", originalName: "", overview: "", popularity: 0, posterPath: nil, productionCompanies: [], seasons: [], status: "", tagline: "", type: "", voteAverage: 0, voteCount: 0, credits: nil)
        
        let item1: TVDetailCellViewModelMultipleSection.SectionItem = .tvPosterWrapper(vm: TVPosterWrapperCellViewModel(tvDetailModel))
        
        let item2: TVDetailCellViewModelMultipleSection.SectionItem = .tvOverview(vm: MediaOverviewCellViewModel(tvDetailModel2))
        
        viewModel.output.sectionedItems.accept([
            .tvPosterWrapperSection(title: "Poster", items: [item1]),
            .tvPosterWrapperSection(title: "Overview", items: [item2])
        ])
        
        XCTAssertEqual(controller.dataSource[0].items.first?.identity, "123")
        XCTAssertEqual(controller.dataSource[1].items.first?.identity, "456")
        
    }
    
    
}
