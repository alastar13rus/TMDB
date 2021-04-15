//
//  MovieDetailCellViewModelMultipleSectionTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 13.04.2021.
//

import XCTest
@testable import TMDB

class MovieDetailCellViewModelMultipleSectionTest: XCTestCase {
    
    func test_initMoviePosterWrapperSection() {
        
        let sectionItem: MovieDetailCellViewModelMultipleSection.SectionItem = .moviePosterWrapper(vm: moviePosterWrapperCellViewModel)
        let sut: MovieDetailCellViewModelMultipleSection = .moviePosterWrapperSection(title: Title.moviePosterWrapper.rawValue, items: [.moviePosterWrapper(vm: moviePosterWrapperCellViewModel)])
        
        XCTAssertEqual(sut.identity, Title.moviePosterWrapper.rawValue)
        XCTAssertEqual(sut.title, Title.moviePosterWrapper.rawValue)
        XCTAssertEqual(sectionItem.identity, "1")
        XCTAssertEqual(sut.items.first, MovieDetailCellViewModelMultipleSection.SectionItem.moviePosterWrapper(vm: moviePosterWrapperCellViewModel))
        
        let sut2 = MovieDetailCellViewModelMultipleSection(original: sut, items: [sectionItem])
        
        XCTAssertEqual(sut2.identity, Title.moviePosterWrapper.rawValue)
        XCTAssertEqual(sut2.title, Title.moviePosterWrapper.rawValue)
        XCTAssertEqual(sectionItem.identity, "1")
        XCTAssertEqual(
            sut2.items.first,
            MovieDetailCellViewModelMultipleSection.SectionItem.moviePosterWrapper(vm: moviePosterWrapperCellViewModel))
    }
    
    func test_initMovieOverviewSection() {
        
        let sectionItem: MovieDetailCellViewModelMultipleSection.SectionItem = .movieOverview(vm: mediaOverviewCellViewModel)
        let sut: MovieDetailCellViewModelMultipleSection = .movieOverviewSection(title: Title.movieOverview.rawValue, items: [.movieOverview(vm: mediaOverviewCellViewModel)])
        
        XCTAssertEqual(sut.identity, Title.movieOverview.rawValue)
        XCTAssertEqual(sut.title, Title.movieOverview.rawValue)
        XCTAssertEqual(sectionItem.identity, "1")
        XCTAssertEqual(sut.items.first, MovieDetailCellViewModelMultipleSection.SectionItem.movieOverview(vm: mediaOverviewCellViewModel))
    }
    
    func test_initMovieRuntimeSection() {
        
        let sectionItem: MovieDetailCellViewModelMultipleSection.SectionItem = .movieRuntime(vm: movieRuntimeCellViewModel)
        let sut: MovieDetailCellViewModelMultipleSection = .movieRuntimeSection(title: Title.movieRuntime.rawValue, items: [.movieRuntime(vm: movieRuntimeCellViewModel)])
        
        XCTAssertEqual(sut.identity, Title.movieRuntime.rawValue)
        XCTAssertEqual(sut.title, Title.movieRuntime.rawValue)
        XCTAssertEqual(sectionItem.identity, "1")
        XCTAssertEqual(sut.items.first, MovieDetailCellViewModelMultipleSection.SectionItem.movieRuntime(vm: movieRuntimeCellViewModel))
    }
    
    func test_initMovieGenresSection() {
        
        let sectionItem: MovieDetailCellViewModelMultipleSection.SectionItem = .movieGenres(vm: genresCellViewModel)
        let sut: MovieDetailCellViewModelMultipleSection = .movieGenresSection(title: Title.movieGenres.rawValue, items: [.movieGenres(vm: genresCellViewModel)])
        
        XCTAssertEqual(sut.identity, Title.movieGenres.rawValue)
        XCTAssertEqual(sut.title, Title.movieGenres.rawValue)
        XCTAssertEqual(sectionItem.identity, "1")
        XCTAssertEqual(sut.items.first, MovieDetailCellViewModelMultipleSection.SectionItem.movieGenres(vm: genresCellViewModel))
    }
    
    func test_initMovieStatusSection() {
        
        let sectionItem: MovieDetailCellViewModelMultipleSection.SectionItem = .movieStatus(vm: movieStatusCellViewModel)
        let sut: MovieDetailCellViewModelMultipleSection = .movieStatusSection(title: Title.movieStatus.rawValue, items: [.movieStatus(vm: movieStatusCellViewModel)])
        
        XCTAssertEqual(sut.identity, Title.movieStatus.rawValue)
        XCTAssertEqual(sut.title, Title.movieStatus.rawValue)
        XCTAssertEqual(sectionItem.identity, "1")
        XCTAssertEqual(sut.items.first, MovieDetailCellViewModelMultipleSection.SectionItem.movieStatus(vm: movieStatusCellViewModel))
    }
    
    func test_initCrewListSection() {
        
        let sectionItem: MovieDetailCellViewModelMultipleSection.SectionItem = .movieCrewList(vm: crewListViewModel)
        let sut: MovieDetailCellViewModelMultipleSection = .movieCrewListSection(title: Title.movieCrewList.rawValue, items: [.movieCrewList(vm: crewListViewModel)])
        
        XCTAssertEqual(sut.identity, Title.movieCrewList.rawValue)
        XCTAssertEqual(sut.title, Title.movieCrewList.rawValue)
        XCTAssertEqual(sectionItem.identity, "crewList")
        XCTAssertEqual(sut.items.first, MovieDetailCellViewModelMultipleSection.SectionItem.movieCrewList(vm: crewListViewModel))
    }
    
    func test_initCastListSection() {
        
        let sectionItem: MovieDetailCellViewModelMultipleSection.SectionItem = .movieCastList(vm: castListViewModel)
        let sut: MovieDetailCellViewModelMultipleSection = .movieCastListSection(title: Title.movieCastList.rawValue, items: [.movieCastList(vm: castListViewModel)])
        
        XCTAssertEqual(sut.identity, Title.movieCastList.rawValue)
        XCTAssertEqual(sut.title, Title.movieCastList.rawValue)
        XCTAssertEqual(sectionItem.identity, "castList")
        XCTAssertEqual(sut.items.first, MovieDetailCellViewModelMultipleSection.SectionItem.movieCastList(vm: castListViewModel))
    }
    
//    MARK: - Helpers
    
    enum Title: String {
        case moviePosterWrapper
        case movieOverview
        case movieRuntime
        case movieGenres
        case movieCrewList
        case movieCastList
        case movieStatus
    }
    
    var castList: [CastModel] = [
        .init(adult: false, gender: 1, id: 1, knownForDepartment: "", name: "", originalName: "", popularity: 0, profilePath: nil, character: "", creditID: "", order: 1)
    ]
    
    var crewList: [CrewModel] = [
        .init(adult: false, gender: 2, id: 2, knownForDepartment: "", name: "", originalName: "", popularity: 0, profilePath: nil, creditID: "", department: "", job: "")
    ]
    
    var movieDetail: MovieDetailModel {
        MovieDetailModel(adult: false, backdropPath: nil, budget: 0, genres: [], homepage: "", id: 1, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: nil, productionCountries: [], productionCompanies: [], releaseDate: nil, revenue: 0, runtime: 60, spokenLanguages: [], status: "", tagline: "", title: "", voteAverage: 10, voteCount: 10, video: false, credits: MediaCreditList(cast: castList, crew: crewList))
    }
    
    var moviePosterWrapperCellViewModel: MoviePosterWrapperCellViewModel { MoviePosterWrapperCellViewModel(movieDetail) }
    var mediaOverviewCellViewModel: MediaOverviewCellViewModel { MediaOverviewCellViewModel(movieDetail) }
    var movieRuntimeCellViewModel: MovieRuntimeCellViewModel { MovieRuntimeCellViewModel(movieDetail) }
    var movieStatusCellViewModel: MediaStatusCellViewModel { MediaStatusCellViewModel(movieDetail) }
    var genresCellViewModel: GenresCellViewModel { GenresCellViewModel(movieDetail) }
    var crewListViewModel: CrewListViewModel { CrewListViewModel(title: Title.movieCrewList.rawValue, items: movieDetail.credits!.crew.map { CrewCellViewModel($0) })}
    var castListViewModel: CastListViewModel { CastListViewModel(title: Title.movieCastList.rawValue, items: movieDetail.credits!.cast.map { CastCellViewModel($0) })}
    
}
