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
    let disposeBag = DisposeBag()
    
    
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

    fileprivate func fetchPeopleID(with creditID: String, completion: @escaping (String) -> Void) {
            networkManager.request(TmdbAPI.credit(.details(creditID: creditID)), completion: { (result: Result<CreditDetailModel, Error>) in
                switch result {
                case .success(let creditDetail):
                    let peopleID = "\(creditDetail.person.id)"
                    completion(peopleID)
                case .failure: break
                }
            })
    }
    
    func setupOutput() {
        fetch { [weak self] (movieDetail) in
            guard let self = self else { return }
            
            let sections = self.configureSections(from: movieDetail)
            self.output.sectionedItems.accept(sections)
        }
    }
    
    func fetch(completion: @escaping (MovieDetailModel) -> Void) {
        self.networkManager.request(TmdbAPI.movies(.details(mediaID: detailID, appendToResponse: [.credits, .recommendations, .similar, .images], includeImageLanguage: [.ru, .null]))) { (result: Result<MovieDetailModel, Error>) in
            
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
            .buildSection(withModel: model, andAction: self.configureMovieImageListSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieOverviewSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieRuntimeSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieGenresSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieStatusSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieCrewListSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieCastListSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieCompilationListSection(withModel:sections:mediaListType:), param: MediaListType.recommendation)
            .buildSection(withModel: model, andAction: self.configureMovieCompilationListSection(withModel:sections:mediaListType:), param: MediaListType.similar)
        
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
    
    fileprivate func configureMovieImageListSection(withModel model: MovieDetailModel, sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {
        let title = "Фото"
        guard var images = model.images?.posters, !images.isEmpty else { return sections }
        images.removeFirst()
        guard !images.isEmpty else { return sections }
        var sections = sections
        
        let items: [MovieDetailCellViewModelMultipleSection.SectionItem] = [.movieImageList(vm: ImageListViewModel(title: title, items: images.map { ImageCellViewModel($0, imageType: .backdrop) }))]
        
        let imageListSection: MovieDetailCellViewModelMultipleSection = .movieImageListSection(title: title, items: items)
        
        sections.append(imageListSection)
        return sections
    }
    
    fileprivate func configureMovieOverviewSection(withModel model: MovieDetailModel, sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {
        
        var sections = sections
        guard !model.overview.isEmpty else { return sections }
        
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
        let crewCount = model.credits?.crew.count ?? 0
        let limit = 10
        let title = "Создатели"
        
        guard let crewList = model.credits?.crew.toUnique().sorted(by: >).prefix(limit), !crewList.isEmpty else { return sections }
        
        
        let crewSection: [CreditCellViewModelMultipleSection.SectionItem] =
            crewList.map { .crew(vm: CrewCellViewModel($0)) }
        
        let showMoreSection: [CreditCellViewModelMultipleSection.SectionItem] =
            [.showMore(vm: ShowMoreCellViewModel(title: "Показать еще", type: .crew))]
        
        var items = [CreditCellViewModelMultipleSection.SectionItem]()
        items.append(contentsOf: crewSection)
        if crewCount > limit { items.append(contentsOf: showMoreSection) }
        
        let movieCrewListSectionItems: [MovieDetailCellViewModelMultipleSection.SectionItem] = [
            .movieCrewList(vm: CreditShortListViewModel(title: title, items: items, coordinator: coordinator, networkManager: networkManager, mediaID: detailID, creditType: .crew))
        ]
        
        let movieCrewListSection: MovieDetailCellViewModelMultipleSection =
            .movieCrewListSection(title: title, items: movieCrewListSectionItems)
        
        sections.append(movieCrewListSection)
        
        return sections
    }
    
    fileprivate func configureMovieCastListSection(withModel model: MovieDetailModel, sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {
        
        var sections = sections
        let castCount = model.credits?.cast.count ?? 0
        let limit = 10
        let title = "Актеры"
        
        guard let castList = model.credits?.cast.prefix(limit), !castList.isEmpty else { return sections }
        
        
        let castSection: [CreditCellViewModelMultipleSection.SectionItem] =
            castList.map { .cast(vm: CastCellViewModel($0)) }
        
        let showMoreSection: [CreditCellViewModelMultipleSection.SectionItem] =
            [.showMore(vm: ShowMoreCellViewModel(title: "Показать еще", type: .cast))]
        
        var items = [CreditCellViewModelMultipleSection.SectionItem]()
        items.append(contentsOf: castSection)
        if castCount > limit { items.append(contentsOf: showMoreSection) }
        
        let movieCastListSectionItems: [MovieDetailCellViewModelMultipleSection.SectionItem] = [
            .movieCastList(vm: CreditShortListViewModel(title: title, items: items, coordinator: coordinator, networkManager: networkManager, mediaID: detailID, creditType: .cast))
        ]
        
        let movieCastListSection: MovieDetailCellViewModelMultipleSection =
            .movieCastListSection(title: title, items: movieCastListSectionItems)
        
        sections.append(movieCastListSection)
        
        return sections
    }
    
    fileprivate func configureMovieCompilationListSection(withModel model: MovieDetailModel, sections: [MovieDetailCellViewModelMultipleSection], mediaListType: MediaListType) -> [MovieDetailCellViewModelMultipleSection] {
        
        var sections = sections
        let limit = 10
        let title = mediaListType.title
        var movieList = [MovieModel]()
        
        switch mediaListType {
        case .recommendation:
            guard let list = model.recommendations?.results.prefix(limit), !list.isEmpty else { return sections }
            movieList = Array(list)
        case .similar:
            guard let list = model.similar?.results.prefix(limit), !list.isEmpty else { return sections }
            movieList = Array(list)
        }
        
        let section: [MediaCellViewModel] = movieList.map { MediaCellViewModel($0) }
        
        let movieListSectionItems: [MovieDetailCellViewModelMultipleSection.SectionItem] = [
            .movieCompilationList(vm: MediaCompilationListViewModel(title: title, items: section, coordinator: coordinator, networkManager: networkManager, mediaListType: mediaListType))
        ]
        
        let movieListSection: MovieDetailCellViewModelMultipleSection =
            .movieCompilationListSection(title: title, items: movieListSectionItems)
        
        sections.append(movieListSection)
        
        return sections
    }
    
}
