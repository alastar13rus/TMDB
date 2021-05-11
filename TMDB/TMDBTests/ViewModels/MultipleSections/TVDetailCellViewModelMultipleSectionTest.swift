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
    
    func test_initCastListSection() {
        
        let sectionItem: TVDetailCellViewModelMultipleSection.SectionItem = .tvCastShortList(vm: castListViewModel)
        let sut: TVDetailCellViewModelMultipleSection = .tvCastShortListSection(title: Title.tvCastList.rawValue, items: [.tvCastShortList(vm: castListViewModel)])
        
        XCTAssertEqual(sut.identity, Title.tvCastList.rawValue)
        XCTAssertEqual(sut.title, Title.tvCastList.rawValue)
        XCTAssertEqual(sectionItem.identity, CreditType.cast.rawValue)
        XCTAssertEqual(sut.items.first, TVDetailCellViewModelMultipleSection.SectionItem.tvCastShortList(vm: castListViewModel))
    }
    
    func test_initCrewListSection() {
        
        let sectionItem: TVDetailCellViewModelMultipleSection.SectionItem = .tvCrewShortList(vm: crewListViewModel)
        let sut: TVDetailCellViewModelMultipleSection = .tvCrewShortListSection(title: Title.tvCrewList.rawValue, items: [.tvCrewShortList(vm: crewListViewModel)])
        
        XCTAssertEqual(sut.identity, Title.tvCrewList.rawValue)
        XCTAssertEqual(sut.title, Title.tvCrewList.rawValue)
        XCTAssertEqual(sectionItem.identity, CreditType.crew.rawValue)
        XCTAssertEqual(sut.items.first, TVDetailCellViewModelMultipleSection.SectionItem.tvCrewShortList(vm: crewListViewModel))
    }
    
//    MARK: - Helpers
    
    enum Title: String {
        case tvPosterWrapper
        case tvOverview
        case tvRuntime
        case tvGenres
        case tvCastList
        case tvCrewList
        case tvStatus
    }
    
    var castModel = CastModel(adult: false, gender: 1, id: 1, knownForDepartment: "", name: "", originalName: "", popularity: 0, profilePath: nil, character: "", creditID: "", order: 1)
    
    lazy var castList = [castModel]
    
    var crewModel = CrewModel(adult: false, gender: 2, id: 2, knownForDepartment: "", name: "", originalName: "", popularity: 0, profilePath: nil, creditID: "", department: "", job: "")
    
    lazy var crewList = [crewModel]
    
    let tvEpisodeDetailModel = TVEpisodeDetailModel(airDate: nil, episodeNumber: 0, id: 1, name: "", overview: "", seasonNumber: 0, stillPath: nil, voteAverage: 0, voteCount: 0, credits: nil, images: nil, videos: nil)
    
    var tvDetail: TVDetailModel {
        TVDetailModel(backdropPath: nil, createdBy: [], episodeRunTime: [0], firstAirDate: "", genres: [], homepage: "", id: 2, inProduction: false, languages: [], lastAirDate: "", lastEpisodeToAir: tvEpisodeDetailModel, name: "", networks: [], numberOfEpisodes: 0, numberOfSeasons: 0, originCountry: [], originalLanguage: "", originalName: "", overview: "", popularity: 0, posterPath: nil, productionCompanies: [], seasons: [], status: "", tagline: "", type: "", voteAverage: 0, voteCount: 0, aggregateCredits: nil, credits: MediaCreditList(cast: castList, crew: crewList), recommendations: nil, similar: nil, images: nil, videos: nil)
    }
    
    var tvPosterWrapperCellViewModel: TVPosterWrapperCellViewModel { TVPosterWrapperCellViewModel(tvDetail) }
    var mediaOverviewCellViewModel: MediaOverviewCellViewModel { MediaOverviewCellViewModel(tvDetail) }
    var tvRuntimeCellViewModel: TVRuntimeCellViewModel { TVRuntimeCellViewModel(tvDetail) }
    var tvStatusCellViewModel: MediaStatusCellViewModel { MediaStatusCellViewModel(tvDetail) }
    var genresCellViewModel: GenresCellViewModel { GenresCellViewModel(tvDetail) }
    
    var castListViewModel: CreditShortListViewModel {
        CreditShortListViewModel(title: Title.tvCastList.rawValue, items: [.cast(vm: CastCellViewModel(castModel))], coordinator: nil, networkManager: nil, mediaID: "1399", creditType: .cast)
    }
    
    var crewListViewModel: CreditShortListViewModel {
        CreditShortListViewModel(title: Title.tvCrewList.rawValue, items: [.crew(vm: CrewCellViewModel(crewModel))], coordinator: nil, networkManager: nil, mediaID: "1399", creditType: .crew)
    }
    
}
