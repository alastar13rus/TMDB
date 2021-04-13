//
//  MovieDetailViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.04.2021.
//

import Foundation
import RxSwift
import RxRelay

class MovieDetailViewModel: DetailViewModelType {
    
//    MARK: - Properties
    let networkManager: NetworkManagerProtocol
    let detailID: String
    weak var coordinator: Coordinator?
    
    
//    MARK: - Input
    
    struct Input {
        
    }
    
    let input = Input()
    
    
    
//    MARK: - Output
    
    struct Output {
        let title = BehaviorRelay<String>(value: "")
        let posterAbsolutePath = BehaviorRelay<URL?>(value: URL(string: ""))
        let backdropAbsolutePath = BehaviorRelay<URL?>(value: URL(string: ""))
        let sectionedItems = BehaviorRelay<[MovieDetailCellViewModelMultipleSection]>(value: [])
    }
    
    let output = Output()
    
//    MARK: - Init
    required init(with detailID: String, networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        self.detailID = detailID
        
        fetch { [weak self] (movieDetail) in
            guard let self = self else { return }
            
            let sections = self.configureSections(from: movieDetail)
            self.output.sectionedItems.accept(sections)
            
        }
        
    }
    
//    MARK: - Methods
    
    private func fetch(completion: @escaping (MovieDetailModel) -> Void) {
        self.networkManager.request(TmdbAPI.movies(.details(mediaID: detailID, appendToResponse: [.credits]))) { (result: Result<MovieDetailModel, Error>) in
            
            switch result {
            case .success(let movieDetail):
                completion(movieDetail)
                
            case .failure(_): break
            }
        }
    }
    
    private func refreshOutput(with section: MovieDetailCellViewModelMultipleSection) {
        
        switch section.items[0] {
        case .moviePosterWrapper(let vm):
            self.output.title.accept(vm.title)

            var posterAbsolutePath: URL? {
                return ImageURL.poster(.w500, vm.posterPath).fullURL
            }

            var backdropAbsolutePath: URL? {
                return ImageURL.backdrop(.w780, vm.backdropPath).fullURL
            }
            self.output.posterAbsolutePath.accept(posterAbsolutePath)
            self.output.backdropAbsolutePath.accept(backdropAbsolutePath)

        default: break
        }
    }
    
    private func configureSections(from model: MovieDetailModel) -> [MovieDetailCellViewModelMultipleSection] {
        
        let sections = [MovieDetailCellViewModelMultipleSection]()
        
        return sections
            .buildSections(withModel: model, andAction: self.configureMoviePosterWrapperSection(withModel:sections:))
            .buildSections(withModel: model, andAction: self.configureMovieOverviewSection(withModel:sections:))
            .buildSections(withModel: model, andAction: self.configureMovieRuntimeSection(withModel:sections:))
            .buildSections(withModel: model, andAction: self.configureMovieGenresSection(withModel:sections:))
            .buildSections(withModel: model, andAction: self.configureMovieStatusSection(withModel:sections:))
            .buildSections(withModel: model, andAction: self.configureMovieCrewListSection(withModel:sections:))
            .buildSections(withModel: model, andAction: self.configureMovieCastListSection(withModel:sections:))
        
    }
    
    fileprivate func configureMoviePosterWrapperSection(withModel model: MovieDetailModel, sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {

        var sections = sections

        let moviePosterWrapperSection: MovieDetailCellViewModelMultipleSection =
            .moviePosterWrapperSection(
                title: "Poster",
                items: [.moviePosterWrapper(vm: MoviePosterWrapperCellViewModel(model))])

        sections.append(moviePosterWrapperSection)

        refreshOutput(with: moviePosterWrapperSection)

        return sections
    }

    
    fileprivate func configureMovieOverviewSection(withModel model: MovieDetailModel, sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        let movieOverviewSection: MovieDetailCellViewModelMultipleSection =
            .moviePosterWrapperSection(
                title: "Overview",
                items: [.movieOverview(vm: MediaOverviewCellViewModel(model))])
        
        sections.append(movieOverviewSection)
        return sections
    }
    
    fileprivate func configureMovieRuntimeSection(withModel model: MovieDetailModel, sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        let movieRuntimeSection: MovieDetailCellViewModelMultipleSection =
            .movieRuntimeSection(
                title: "Продолжительность",
                items: [.movieRuntime(vm: MovieRuntimeCellViewModel(model))])
        
        sections.append(movieRuntimeSection)
        return sections
    }
    
    fileprivate func configureMovieGenresSection(withModel model: MovieDetailModel, sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        let movieGenresSection: MovieDetailCellViewModelMultipleSection =
            .movieGenresSection(
                title: "Жанры",
                items: [.movieGenres(vm: GenresCellViewModel(model))])
        
        sections.append(movieGenresSection)
        return sections
    }
    
    fileprivate func configureMovieStatusSection(withModel model: MovieDetailModel, sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        let movieStatusSection: MovieDetailCellViewModelMultipleSection =
            .movieStatusSection(
                title: "Статус",
                items: [.movieStatus(vm: MediaStatusCellViewModel(model))])
        
        sections.append(movieStatusSection)
        return sections
    }
    
    fileprivate func configureMovieCrewListSection(withModel model: MovieDetailModel, sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {

        var sections = sections
        
        
        if let crewList = model.credits?.crew.filter { $0.profilePath != nil }.toUnique().prefix(10), !crewList.isEmpty {
            let title = "Создатели"
            
            let movieCrewListSection: MovieDetailCellViewModelMultipleSection =
                .movieCrewListSection(title: title, items: [.movieCrewList(vm: CrewListViewModel(title: title, items: crewList.map { CrewCellViewModel($0) }))])
            
            sections.append(movieCrewListSection)
        }
        return sections
    }
    
    fileprivate func configureMovieCastListSection(withModel model: MovieDetailModel, sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        if let castList = model.credits?.cast.prefix(10), !castList.isEmpty {
            let title = "Актеры"
            
            let movieCastListSection: MovieDetailCellViewModelMultipleSection =
                .movieCastListSection(title: title, items: [.movieCastList(vm: CastListViewModel(title: title, items: castList.map { CastCellViewModel($0) }))])
            
            sections.append(movieCastListSection)
        }
        return sections
    }
    
    
    
}

extension Array where Array.Element == CrewModel {
    fileprivate func toUnique() -> [CrewModel] {
        var crewListDict = [Int:CrewModel]()
        self.enumerated().forEach { crewListDict[$0.element.id] = $0.element }
        return crewListDict.map { $0.value }
    }
}
