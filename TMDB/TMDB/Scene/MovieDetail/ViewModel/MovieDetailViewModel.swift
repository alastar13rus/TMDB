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
        let backdropImageData = BehaviorRelay<Data?>(value: nil)
        let sectionedItems = BehaviorRelay<[MovieDetailCellViewModelMultipleSection]>(value: [])
    }
    
    let output = Output()
    
//    MARK: - Init
    required init(with detailID: String, networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        self.detailID = detailID
        
        setupOutput()
    }
    
//    MARK: - Methods
    
    func setupOutput() {
        fetch { [weak self] (movieDetail) in
            guard let self = self else { return }
            
            let sections = self.configureSections(from: movieDetail)
            self.output.sectionedItems.accept(sections)
        }
    }
    
    func fetch(completion: @escaping (MovieDetailModel) -> Void) {
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
            
            guard let backdropPath = vm.backdropPath else { self.output.backdropImageData.accept(nil); return }
            guard let backdropAbsolutePath = ImageURL.backdrop(.w780, backdropPath).fullURL else { self.output.backdropImageData.accept(nil); return }
            
            backdropAbsolutePath.downloadImageData(completion: { (imageData) in
                guard let imageData = imageData else {
                    self.output.backdropImageData.accept(nil)
                    return
                }
                self.output.backdropImageData.accept(imageData)
            })
        
        default: break
        }
    }
    
    private func configureSections(from model: MovieDetailModel) -> [MovieDetailCellViewModelMultipleSection] {
        
        let sections = [MovieDetailCellViewModelMultipleSection]()
        
        return sections
            .buildSection(withModel: model, andAction: self.configureMoviePosterWrapperSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieOverviewSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieRuntimeSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieGenresSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieStatusSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieCrewListSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieCastListSection(withModel:sections:))
        
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
        
        
        if let crewList = model.credits?.crew.filter { $0.profilePath != nil }.toUnique().sorted(by: >).prefix(10), !crewList.isEmpty {
            let title = "Создатели"
            
            let crewSection: [CreditCellViewModelMultipleSection.SectionItem] =
                crewList.map { .crew(vm: CrewCellViewModel($0)) }
            
            let showMoreSection: [CreditCellViewModelMultipleSection.SectionItem] =
                [.showMore(vm: ShowMoreCellViewModel(title: "Показать еще", type: .crew))]
            
            let items: [MovieDetailCellViewModelMultipleSection.SectionItem] = [
                .movieCrewList(vm: CreditShortListViewModel(title: title, items: crewSection + showMoreSection, coordinator: coordinator, networkManager: networkManager, mediaID: detailID, creditType: .crew))
            ]
            
            let movieCrewListSection: MovieDetailCellViewModelMultipleSection =
                .movieCrewListSection(title: title, items: items)
            
            sections.append(movieCrewListSection)
        }
        return sections
    }
    
    fileprivate func configureMovieCastListSection(withModel model: MovieDetailModel, sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        if let castList = model.credits?.cast.prefix(10), !castList.isEmpty {
            let title = "Актеры"
            
            let castSection: [CreditCellViewModelMultipleSection.SectionItem] =
                castList.map { .cast(vm: CastCellViewModel($0)) }
            
            let showMoreSection: [CreditCellViewModelMultipleSection.SectionItem] =
                [.showMore(vm: ShowMoreCellViewModel(title: "Показать еще", type: .cast))]
            
            let items: [MovieDetailCellViewModelMultipleSection.SectionItem] = [
                .movieCastList(vm: CreditShortListViewModel(title: title, items: castSection + showMoreSection, coordinator: coordinator, networkManager: networkManager, mediaID: detailID, creditType: .cast))
            ]
            
            let movieCastListSection: MovieDetailCellViewModelMultipleSection =
                .movieCastListSection(title: title, items: items)
            
            sections.append(movieCastListSection)
        }
        return sections
    }
    
    
    
}
