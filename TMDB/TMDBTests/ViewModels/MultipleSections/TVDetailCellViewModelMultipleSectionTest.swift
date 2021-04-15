//
//  TVDetailCellViewModelMultipleSectionTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 14.04.2021.
//

import XCTest
@testable import TMDB

class TVDetailCellViewModelMultipleSectionTest: XCTestCase {
    
    func test_initTVPosterWrapperSection() {
        
        let sectionItem: TVDetailCellViewModelMultipleSection.SectionItem = .tvPosterWrapper(vm: tvPosterWrapperCellViewModel)
        let sut: TVDetailCellViewModelMultipleSection = .tvPosterWrapperSection(title: Title.tvPosterWrapper.rawValue, items: [.tvPosterWrapper(vm: tvPosterWrapperCellViewModel)])
        
        XCTAssertEqual(sut.identity, Title.tvPosterWrapper.rawValue)
        XCTAssertEqual(sut.title, Title.tvPosterWrapper.rawValue)
        XCTAssertEqual(sectionItem.identity, "2")
        XCTAssertEqual(sut.items.first, TVDetailCellViewModelMultipleSection.SectionItem.tvPosterWrapper(vm: tvPosterWrapperCellViewModel))
        
        let sut2 = TVDetailCellViewModelMultipleSection(original: sut, items: [sectionItem])
        
        XCTAssertEqual(sut2.identity, Title.tvPosterWrapper.rawValue)
        XCTAssertEqual(sut2.title, Title.tvPosterWrapper.rawValue)
        XCTAssertEqual(sectionItem.identity, "2")
        XCTAssertEqual(
            sut2.items.first,
            TVDetailCellViewModelMultipleSection.SectionItem.tvPosterWrapper(vm: tvPosterWrapperCellViewModel))
    }
    
    func test_initTVOverviewSection() {
        
        let sectionItem: TVDetailCellViewModelMultipleSection.SectionItem = .tvOverview(vm: mediaOverviewCellViewModel)
        let sut: TVDetailCellViewModelMultipleSection = .tvOverviewSection(title: Title.tvOverview.rawValue, items: [.tvOverview(vm: mediaOverviewCellViewModel)])
        
        XCTAssertEqual(sut.identity, Title.tvOverview.rawValue)
        XCTAssertEqual(sut.title, Title.tvOverview.rawValue)
        XCTAssertEqual(sectionItem.identity, "2")
        XCTAssertEqual(sut.items.first, TVDetailCellViewModelMultipleSection.SectionItem.tvOverview(vm: mediaOverviewCellViewModel))
    }
    
    func test_initTVRuntimeSection() {
        
        let sectionItem: TVDetailCellViewModelMultipleSection.SectionItem = .tvRuntime(vm: tvRuntimeCellViewModel)
        let sut: TVDetailCellViewModelMultipleSection = .tvRuntimeSection(title: Title.tvRuntime.rawValue, items: [.tvRuntime(vm: tvRuntimeCellViewModel)])
        
        XCTAssertEqual(sut.identity, Title.tvRuntime.rawValue)
        XCTAssertEqual(sut.title, Title.tvRuntime.rawValue)
        XCTAssertEqual(sectionItem.identity, "2")
        XCTAssertEqual(sut.items.first, TVDetailCellViewModelMultipleSection.SectionItem.tvRuntime(vm: tvRuntimeCellViewModel))
    }
    
    func test_initTVGenresSection() {
        
        let sectionItem: TVDetailCellViewModelMultipleSection.SectionItem = .tvGenres(vm: genresCellViewModel)
        let sut: TVDetailCellViewModelMultipleSection = .tvGenresSection(title: Title.tvGenres.rawValue, items: [.tvGenres(vm: genresCellViewModel)])
        
        XCTAssertEqual(sut.identity, Title.tvGenres.rawValue)
        XCTAssertEqual(sut.title, Title.tvGenres.rawValue)
        XCTAssertEqual(sectionItem.identity, "2")
        XCTAssertEqual(sut.items.first, TVDetailCellViewModelMultipleSection.SectionItem.tvGenres(vm: genresCellViewModel))
    }
    
    func test_initTVStatusSection() {
        
        let sectionItem: TVDetailCellViewModelMultipleSection.SectionItem = .tvStatus(vm: tvStatusCellViewModel)
        let sut: TVDetailCellViewModelMultipleSection = .tvStatusSection(title: Title.tvStatus.rawValue, items: [.tvStatus(vm: tvStatusCellViewModel)])
        
        XCTAssertEqual(sut.identity, Title.tvStatus.rawValue)
        XCTAssertEqual(sut.title, Title.tvStatus.rawValue)
        XCTAssertEqual(sectionItem.identity, "2")
        XCTAssertEqual(sut.items.first, TVDetailCellViewModelMultipleSection.SectionItem.tvStatus(vm: tvStatusCellViewModel))
    }
    
    func test_initCreatorsSection() {
        
        let sectionItem: TVDetailCellViewModelMultipleSection.SectionItem = .tvCreators(vm: creatorWithPhotoCellViewModel)
        let sut: TVDetailCellViewModelMultipleSection = .tvCreatorsSection(title: Title.tvCreatorWithPhoto.rawValue, items: [sectionItem])
        XCTAssertEqual(sut.identity, Title.tvCreatorWithPhoto.rawValue)
        XCTAssertEqual(sut.title, Title.tvCreatorWithPhoto.rawValue)
        XCTAssertEqual(sectionItem.identity, "2")
        XCTAssertEqual(sut.items.first, TVDetailCellViewModelMultipleSection.SectionItem.tvCreators(vm: creatorWithPhotoCellViewModel))
    }
    
    func test_initCastListSection() {
        
        let sectionItem: TVDetailCellViewModelMultipleSection.SectionItem = .tvCastList(vm: castListViewModel)
        let sut: TVDetailCellViewModelMultipleSection = .tvCastListSection(title: Title.tvCastList.rawValue, items: [.tvCastList(vm: castListViewModel)])
        
        XCTAssertEqual(sut.identity, Title.tvCastList.rawValue)
        XCTAssertEqual(sut.title, Title.tvCastList.rawValue)
        XCTAssertEqual(sectionItem.identity, "castList")
        XCTAssertEqual(sut.items.first, TVDetailCellViewModelMultipleSection.SectionItem.tvCastList(vm: castListViewModel))
    }
    
//    MARK: - Helpers
    
    enum Title: String {
        case tvPosterWrapper
        case tvOverview
        case tvRuntime
        case tvGenres
        case tvCreatorWithPhoto
        case tvCastList
        case tvStatus
    }
    
    var castList: [CastModel] = [
        .init(adult: false, gender: 1, id: 1, knownForDepartment: "", name: "", originalName: "", popularity: 0, profilePath: nil, character: "", creditID: "", order: 1)
    ]
    
    var creator = CreatorModel(id: 2, creditID: "", name: "", gender: 2, profilePath: nil)
    
    var tvDetail: TVDetailModel {
        TVDetailModel(backdropPath: nil, createdBy: [creator], episodeRunTime: [0], firstAirDate: "", genres: [], homepage: "", id: 2, inProduction: false, languages: [], lastAirDate: "", lastEpisodeToAir: TVEpisodeModel(), name: "", networks: [], numberOfEpisodes: 0, numberOfSeasons: 0, originCountry: [], originalLanguage: "", originalName: "", overview: "", popularity: 0, posterPath: nil, productionCompanies: [], seasons: [], status: "", tagline: "", type: "", voteAverage: 0, voteCount: 0, credits: MediaCreditList(cast: castList, crew: []))
    }
    
    var tvPosterWrapperCellViewModel: TVPosterWrapperCellViewModel { TVPosterWrapperCellViewModel(tvDetail) }
    var mediaOverviewCellViewModel: MediaOverviewCellViewModel { MediaOverviewCellViewModel(tvDetail) }
    var tvRuntimeCellViewModel: TVRuntimeCellViewModel { TVRuntimeCellViewModel(tvDetail) }
    var tvStatusCellViewModel: MediaStatusCellViewModel { MediaStatusCellViewModel(tvDetail) }
    var genresCellViewModel: GenresCellViewModel { GenresCellViewModel(tvDetail) }
    var creatorWithPhotoCellViewModel: CreatorWithPhotoCellViewModel { CreatorWithPhotoCellViewModel(creator) }
        
    var castListViewModel: CastListViewModel { CastListViewModel(title: Title.tvCastList.rawValue, items: tvDetail.credits!.cast.map { CastCellViewModel($0) })}
    
}
