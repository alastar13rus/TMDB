//
//  MovieDetailViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.04.2021.
//

import Foundation
import RxSwift
import RxRelay
import Swinject
import Domain

class MovieDetailViewModel {
    
// MARK: - Properties
    private let useCaseProvider: Domain.UseCaseProvider
    private let useCasePersistenceProvider: Domain.UseCasePersistenceProvider
    private let networkMonitor: Domain.NetworkMonitor

    private(set) var detailID: String
    private var movieModel: MovieModel? {
        didSet {
            self.isFavorite(movieModel!) { self.output.isFavorite.accept($0) }
        }
    }
    weak var coordinator: Coordinator?
    private let disposeBag = DisposeBag()
    
// MARK: - Input
    
    struct Input {
        let selectedItem = PublishRelay<MovieDetailCellViewModelMultipleSection.SectionItem>()
        let toggleFavoriteStatus = PublishRelay<Void>()
        let viewWillAppear = PublishRelay<Void>()
    }
    
    let input = Input()
    
// MARK: - Output
    
    struct Output {
        let title = BehaviorRelay<String>(value: "")
        let backdropImageData = BehaviorRelay<Data?>(value: nil)
        let sectionedItems = BehaviorRelay<[MovieDetailCellViewModelMultipleSection]>(value: [])
        let isFavorite = PublishRelay<Bool>()
    }
    
    let output = Output()
    
// MARK: - Init
    required init(with detailID: String,
                  useCaseProvider: Domain.UseCaseProvider,
                  useCasePersistenceProvider: Domain.UseCasePersistenceProvider,
                  networkMonitor: Domain.NetworkMonitor) {
        self.useCaseProvider = useCaseProvider
        self.useCasePersistenceProvider = useCasePersistenceProvider
        self.networkMonitor = networkMonitor

        self.detailID = detailID
        
        setupInput()
        setupOutput()
    }
    
// MARK: - Methods
    
    fileprivate func setupInput() {
        input.selectedItem
            .filter { if case .movieTrailerButton = $0 { return true } else { return false } }
            .subscribe(onNext: { [weak self] _ in
                guard let self = self, let coordinator = self.coordinator as? MovieFlowCoordinator else { return }
                coordinator.toTrailerList(with: self.detailID, mediaType: .movie)
            }).disposed(by: disposeBag)
        
        input.toggleFavoriteStatus.subscribe(onNext: { [weak self] in
            self?.toggleFavoriteStatus()
        }).disposed(by: disposeBag)
        
        input.viewWillAppear.subscribe(onNext: { [weak self] in
            self?.refreshFavoriteStatus()
        }).disposed(by: disposeBag)
    }
    
    private func toggleFavoriteStatus() {
        let useCase = useCasePersistenceProvider.makeFavoriteMovieUseCase()
        guard let movieModel = movieModel else { return }
        useCase.toggleFavoriteStatus(movieModel) { [weak self] (isFavorite) in
            self?.output.isFavorite.accept(isFavorite)
        }
    }
    
    private func refreshFavoriteStatus() {
        guard let movieModel = movieModel else { return }
        isFavorite(movieModel) { [weak self] (isFavorite) in
            self?.output.isFavorite.accept(isFavorite)
        }
    }
    
    private func isFavorite(_ model: MovieModel, _ completion: @escaping (Bool) -> Void) {
        let useCase = useCasePersistenceProvider.makeFavoriteMovieUseCase()
        useCase.isFavorite(model) { completion($0) }

    }
    
    func setupOutput() {
        fetch { [weak self] (movieDetail) in
            guard let self = self else { return }
            
            self.movieModel = MovieModel(movieDetail)
            let sections = self.configureSections(from: movieDetail)
            self.output.sectionedItems.accept(sections)
        }
    }
    
    func fetch(completion: @escaping (MovieDetailModel) -> Void) {
        
        let useCase = useCaseProvider.makeMovieDetailUseCase()
        useCase.details(mediaID: mediaID,
                        appendToResponse: [.credits,
                                            .recommendations,
                                            .similar,
                                            .images,
                                            .videos],
                        includeImageLanguage: [.ru, .null]) { [weak self] (result: Result<MovieDetailModel, Error>) in
            
            switch result {
            case .success(let movieDetail):
                completion(movieDetail)
                
            case .failure(let error):
                self?.inform(with: error.localizedDescription)
            }
        }
    }
    
    private func refreshOutput(with section: MovieDetailCellViewModelMultipleSection) {
        
        if case .moviePosterWrapper(let vm) = section.items.first {
            self.output.title.accept(vm.title)
        }
    }
    
    private func configureSections(from model: MovieDetailModel) -> [MovieDetailCellViewModelMultipleSection] {
        
        let sections = [MovieDetailCellViewModelMultipleSection]()
        
        return sections
            .buildSection(withModel: model, andAction: self.configureMoviePosterWrapperSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieImageListSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieTrailerButtonSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieOverviewSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieRuntimeSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieGenresSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieStatusSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieCrewListSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureMovieCastListSection(withModel:sections:))
            .buildSection(withModel: model,
                          andAction: self.configureMovieCompilationListSection(withModel:sections:mediaListType:),
                          param: MediaListType.recommendation)
            .buildSection(withModel: model,
                          andAction: self.configureMovieCompilationListSection(withModel:sections:mediaListType:),
                          param: MediaListType.similar)
        
    }
    
    fileprivate func configureMoviePosterWrapperSection(
        withModel model: MovieDetailModel,
        sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {

        var sections = sections

        let moviePosterWrapperSection: MovieDetailCellViewModelMultipleSection =
            .moviePosterWrapperSection(
                title: "Poster",
                items: [.moviePosterWrapper(vm: MoviePosterWrapperCellViewModel(model))])

        sections.append(moviePosterWrapperSection)

        refreshOutput(with: moviePosterWrapperSection)

        return sections
    }
    
    fileprivate func configureMovieImageListSection(
        withModel model: MovieDetailModel,
        sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {
        
        let title = "Фото"
        guard let images = model.images?.backdrops, !images.isEmpty else { return sections }
        var sections = sections
        
        guard let coordinator = coordinator as? ToImageFullScreenRoutable else { return sections }
        
        let items: [MovieDetailCellViewModelMultipleSection.SectionItem] = [
            .movieImageList(vm: ImageListViewModel(title: title,
                                                   items: images.map { ImageCellViewModel($0, imageType: .backdrop(size: .small)) },
                                                   coordinator: coordinator,
                                                   contentForm: .landscape))]
        
        let imageListSection: MovieDetailCellViewModelMultipleSection = .movieImageListSection(title: title, items: items)
        
        sections.append(imageListSection)
        return sections
    }
    
    fileprivate func configureMovieTrailerButtonSection(
        withModel model: MovieDetailModel,
        sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {
        
        let title = "Смотреть трейлеры"
        guard let videos = model.videos?.results, !videos.isEmpty else { return sections }
        var sections = sections

        let items: [MovieDetailCellViewModelMultipleSection.SectionItem] = [
            .movieTrailerButton(vm: ButtonCellViewModel(title: title, type: .trailer))
        ]

        let imageListSection: MovieDetailCellViewModelMultipleSection = .movieTrailerButtonSection(title: title, items: items)

        sections.append(imageListSection)
        return sections
    }
    
    fileprivate func configureMovieOverviewSection(
        withModel model: MovieDetailModel,
        sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {
        
        var sections = sections
        guard !model.overview.isEmpty else { return sections }
        
        let movieOverviewSection: MovieDetailCellViewModelMultipleSection =
            .moviePosterWrapperSection(
                title: "Overview",
                items: [.movieOverview(vm: MediaOverviewCellViewModel(model))])
        
        sections.append(movieOverviewSection)
        return sections
    }
    
    fileprivate func configureMovieRuntimeSection(
        withModel model: MovieDetailModel,
        sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        let movieRuntimeSection: MovieDetailCellViewModelMultipleSection =
            .movieRuntimeSection(
                title: "Продолжительность",
                items: [.movieRuntime(vm: MovieRuntimeCellViewModel(model))])
        
        sections.append(movieRuntimeSection)
        return sections
    }
    
    fileprivate func configureMovieGenresSection(
        withModel model: MovieDetailModel,
        sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        let movieGenresSection: MovieDetailCellViewModelMultipleSection =
            .movieGenresSection(
                title: "Жанры",
                items: [.movieGenres(vm: GenresCellViewModel(model))])
        
        sections.append(movieGenresSection)
        return sections
    }
    
    fileprivate func configureMovieStatusSection(
        withModel model: MovieDetailModel,
        sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        let movieStatusSection: MovieDetailCellViewModelMultipleSection =
            .movieStatusSection(
                title: "Статус",
                items: [.movieStatus(vm: MediaStatusCellViewModel(model))])
        
        sections.append(movieStatusSection)
        return sections
    }
    
    fileprivate func configureMovieCrewListSection(
        withModel model: MovieDetailModel,
        sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {
        
        var sections = sections
        let crewCount = model.credits?.crew.count ?? 0
        let limit = 10
        let title = "Съемочная группа"
        
        guard let crewList = model.credits?.crew.toUnique().sorted(by: >).prefix(limit), !crewList.isEmpty else { return sections }
        
        let crewSection: [CreditCellViewModelMultipleSection.SectionItem] =
            crewList.map { .crew(vm: CrewCellViewModel($0)) }
        
        let showMoreSection: [CreditCellViewModelMultipleSection.SectionItem] =
            [.showMore(vm: ShowMoreCellViewModel(title: "Показать еще", type: .crew))]
        
        var items = [CreditCellViewModelMultipleSection.SectionItem]()
        items.append(contentsOf: crewSection)
        if crewCount > limit { items.append(contentsOf: showMoreSection) }
        
        let movieCrewListSectionItems: [MovieDetailCellViewModelMultipleSection.SectionItem] = [
            .movieCrewList(vm: CreditShortListViewModel(title: title, items: items, creditType: .crew, mediaType: .movie, delegate: self))
        ]
        
        let movieCrewListSection: MovieDetailCellViewModelMultipleSection =
            .movieCrewListSection(title: title, items: movieCrewListSectionItems)
        
        sections.append(movieCrewListSection)
        
        return sections
    }
    
    fileprivate func configureMovieCastListSection(
        withModel model: MovieDetailModel,
        sections: [MovieDetailCellViewModelMultipleSection]) -> [MovieDetailCellViewModelMultipleSection] {
        
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
            .movieCastList(vm: CreditShortListViewModel(title: title,
                                                        items: items,
                                                        creditType: .cast,
                                                        mediaType: .movie,
                                                        delegate: self))
        ]
        
        let movieCastListSection: MovieDetailCellViewModelMultipleSection =
            .movieCastListSection(title: title, items: movieCastListSectionItems)
        
        sections.append(movieCastListSection)
        
        return sections
    }
    
    fileprivate func configureMovieCompilationListSection(
        withModel model: MovieDetailModel,
        sections: [MovieDetailCellViewModelMultipleSection],
        mediaListType: MediaListType) -> [MovieDetailCellViewModelMultipleSection] {
        
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
            .movieCompilationList(vm: MediaCompilationListViewModel(title: title,
                                                                    items: section,
                                                                    coordinator: coordinator,
                                                                    useCaseProvider: useCaseProvider,
                                                                    mediaListType: mediaListType))
        ]
        
        let movieListSection: MovieDetailCellViewModelMultipleSection =
            .movieCompilationListSection(title: title, items: movieListSectionItems)
        
        sections.append(movieListSection)
        
        return sections
    }
    
    private func inform(with message: String) {
        networkMonitor.delegate?.inform(with: message)
    }
    
}

extension MovieDetailViewModel: CreditShortListViewModelDelegate {
    var creditShortListDelegateCoordinator: ToPeopleRoutable? { coordinator as? ToPeopleRoutable }
    var mediaID: String { detailID }
    var mediaType: MediaType { .movie }
    var delegateSeasonNumber: String? { nil }
    var delegateEpisodeNumber: String? { nil }
}
