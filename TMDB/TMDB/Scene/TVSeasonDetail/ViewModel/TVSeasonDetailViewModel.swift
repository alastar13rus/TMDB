//
//  TVSeasonDetailViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 04.05.2021.
//

import Foundation
import RxSwift
import RxRelay
import Swinject
import Domain

class TVSeasonDetailViewModel {
    
    
//    MARK: - Properties
    let mediaID: String
    let seasonNumber: String
    
    let networkManager: NetworkManagerProtocol
    weak var coordinator: Coordinator?
    let disposeBag = DisposeBag()
    
    let input = Input()
    let output = Output()
    
    struct Input {
        let selectedItem = PublishSubject<TVSeasonDetailCellViewModelMultipleSection.SectionItem>()
    }
    
    struct Output {
        let title = BehaviorRelay<String>(value: "")
        let posterImageData = BehaviorRelay<Data?>(value: nil)
        let sectionedItems = BehaviorRelay<[TVSeasonDetailCellViewModelMultipleSection]>(value: [])
    }
    
    
    
    
//    MARK: - Init
    required init(with detailID: String, seasonNumber: String, networkManager: NetworkManagerProtocol) {
        self.mediaID = detailID
        self.seasonNumber = seasonNumber
        self.networkManager = networkManager
        
        setupInput()
        setupOutput()
    }
    
    
//    MARK: - Methods
    fileprivate func setupInput() {
        input.selectedItem.subscribe(onNext: { [weak self] in
            guard let self = self, let coordinator = self.coordinator as? TVSeasonFlowCoordinator else { return }
            if case .tvSeasonTrailerButton = $0 {
                coordinator.toTrailerList(with: self.mediaID, mediaType: .tvSeason, seasonNumber: self.seasonNumber)
            }
        }).disposed(by: disposeBag)
    }
    
    fileprivate func setupOutput() {
        fetch { [weak self] (tvSeasonDetail) in
            guard let self = self else { return }
            let sections = self.configureSections(from: tvSeasonDetail)
            self.output.sectionedItems.accept(sections)
        }
    }
    
    fileprivate func fetch(completion: @escaping (TVSeasonDetailModel) -> Void) {
        self.networkManager.request(TmdbAPI.tv(.season(mediaID: mediaID, seasonNumber: seasonNumber, appendToResponse: [ .aggregateCredits, .images, .videos ], includeImageLanguage: []))) { (result: Result<TVSeasonDetailModel, Error>) in
            switch result {
            case .success(let tvSeasonDetail):
                completion(tvSeasonDetail)
            case .failure: break
            }
        }
    }
    
    fileprivate func configureSections(from model: TVSeasonDetailModel) -> [TVSeasonDetailCellViewModelMultipleSection] {
        
        let sections = [TVSeasonDetailCellViewModelMultipleSection]()
        
        return sections
            .buildSection(withModel: model, andAction: self.configureTVSeasonPosterWrapperSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVSeasonImageListSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVSeasonTrailerButtonSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVSeasonOverviewSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVSeasonCrewListSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVSeasonCastListSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVEpisodeShortListSection(withModel:sections:))
//            .buildSection(withModel: model, andAction: self.configureTVCompilationListSection(withModel:sections:mediaListType:), param: MediaListType.recommendation)
//            .buildSection(withModel: model, andAction: self.configureTVCompilationListSection(withModel:sections:mediaListType:), param: MediaListType.similar)
        
    }
    
    private func refreshOutput(with section: TVSeasonDetailCellViewModelMultipleSection) {
        
        switch section.items[0] {
        case .tvSeasonPosterWrapper(let vm):
            self.output.title.accept(vm.name)
            
            guard let posterPath = vm.posterPath else { self.output.posterImageData.accept(nil); return }
            guard let posterAbsolutePath = ImageURL.poster(.w780, posterPath).fullURL else { self.output.posterImageData.accept(nil); return }
            
            posterAbsolutePath.downloadImageData(completion: { (imageData) in
                guard let imageData = imageData else {
                    self.output.posterImageData.accept(nil)
                    return
                }
                self.output.posterImageData.accept(imageData)
            })
        
        default: break
        }
    }
    
    fileprivate func configureTVSeasonPosterWrapperSection(withModel model: TVSeasonDetailModel, sections: [TVSeasonDetailCellViewModelMultipleSection]) -> [TVSeasonDetailCellViewModelMultipleSection] {
    
            var sections = sections

            let tvSeasonPosterWrapperSection: TVSeasonDetailCellViewModelMultipleSection =
                .tvSeasonPosterWrapperSection(
                    title: "Poster",
                    items: [.tvSeasonPosterWrapper(vm: TVSeasonPosterWrapperCellViewModel(model))])

            sections.append(tvSeasonPosterWrapperSection)

            refreshOutput(with: tvSeasonPosterWrapperSection)

            return sections
        }
    
    fileprivate func configureTVSeasonImageListSection(withModel model: TVSeasonDetailModel, sections: [TVSeasonDetailCellViewModelMultipleSection]) -> [TVSeasonDetailCellViewModelMultipleSection] {
        let title = "Фото"
        guard let images = model.images?.posters, !images.isEmpty else { return sections }
        var sections = sections
        
        guard let coordinator = coordinator as? ToImageFullScreenRoutable else { return sections }
        
        let items: [TVSeasonDetailCellViewModelMultipleSection.SectionItem] = [.tvSeasonImageList(vm: ImageListViewModel(title: title, items: images.map { ImageCellViewModel($0, imageType: .backdrop(size: .small)) }, coordinator: coordinator, contentForm: .landscape))]
        
        let imageListSection: TVSeasonDetailCellViewModelMultipleSection = .tvSeasonImageListSection(title: title, items: items)
        
        sections.append(imageListSection)
        return sections
    }
    
    fileprivate func configureTVSeasonTrailerButtonSection(withModel model: TVSeasonDetailModel, sections: [TVSeasonDetailCellViewModelMultipleSection]) -> [TVSeasonDetailCellViewModelMultipleSection] {
        let title = "Смотреть трейлеры"
        guard let videos = model.videos?.results, !videos.isEmpty else { return sections }
        var sections = sections

        let items: [TVSeasonDetailCellViewModelMultipleSection.SectionItem] = [
            .tvSeasonTrailerButton(vm: ButtonCellViewModel(title: title, type: .trailer))
        ]

        let trailerSection: TVSeasonDetailCellViewModelMultipleSection = .tvSeasonTrailerButtonSection(title: title, items: items)

        sections.append(trailerSection)
        return sections
    }
    
    fileprivate func configureTVSeasonOverviewSection(withModel model: TVSeasonDetailModel, sections: [TVSeasonDetailCellViewModelMultipleSection]) -> [TVSeasonDetailCellViewModelMultipleSection] {
        
        var sections = sections
        guard !model.overview.isEmpty else { return sections }
        
        let tvSeasonOverviewSection: TVSeasonDetailCellViewModelMultipleSection =
            .tvSeasonOverviewSection(
                title: "Overview",
                items: [.tvSeasonOverview(vm: TVSeasonOverviewCellViewModel(model))])
        
        sections.append(tvSeasonOverviewSection)
        return sections
    }
    
    fileprivate func configureTVSeasonCrewListSection(withModel model: TVSeasonDetailModel, sections: [TVSeasonDetailCellViewModelMultipleSection]) -> [TVSeasonDetailCellViewModelMultipleSection] {
        
        var sections = sections
        let crewCount = model.aggregateCredits?.crew.count ?? 0
        let limit = 10
        let title = "Съемочная группа"
        
        guard let crewList = model.aggregateCredits?.crew.sorted(by: >).prefix(limit), !crewList.isEmpty else { return sections }
        
        
        let crewSection: [CreditCellViewModelMultipleSection.SectionItem] =
            crewList.map { .aggregateCrew(vm: AggregateCrewCellViewModel($0)) }
        
        let showMoreSection: [CreditCellViewModelMultipleSection.SectionItem] =
            [.showMore(vm: ShowMoreCellViewModel(title: "Показать еще", type: .crew))]

        var items = [CreditCellViewModelMultipleSection.SectionItem]()
        items.append(contentsOf: crewSection)
        if crewCount > limit { items.append(contentsOf: showMoreSection) }

        let tvSeasonCrewListSectionItems: [TVSeasonDetailCellViewModelMultipleSection.SectionItem] =
            [
                .tvSeasonCrewShortList(vm: CreditShortListViewModel(title: title, items: items, creditType: .crew, mediaType: .tvSeason, delegate: self))
            ]

        let tvSeasonCrewListSection: TVSeasonDetailCellViewModelMultipleSection =
            .tvSeasonCrewShortListSection(title: title, items: tvSeasonCrewListSectionItems)

        sections.append(tvSeasonCrewListSection)

        return sections
    }
    
    fileprivate func configureTVSeasonCastListSection(withModel model: TVSeasonDetailModel, sections: [TVSeasonDetailCellViewModelMultipleSection]) -> [TVSeasonDetailCellViewModelMultipleSection] {
        
        var sections = sections
        let castCount = model.aggregateCredits?.cast.count ?? 0
        let limit = 10
        let title = "Актеры"
        
        guard let castList = model.aggregateCredits?.cast.sorted(by: >).prefix(limit), !castList.isEmpty else { return sections }
        
        
        let castSection: [CreditCellViewModelMultipleSection.SectionItem] =
            castList.map { .aggregateCast(vm: AggregateCastCellViewModel($0)) }
        
        let showMoreSection: [CreditCellViewModelMultipleSection.SectionItem] =
            [.showMore(vm: ShowMoreCellViewModel(title: "Показать еще", type: .cast))]

        var items = [CreditCellViewModelMultipleSection.SectionItem]()
        items.append(contentsOf: castSection)
        if castCount > limit { items.append(contentsOf: showMoreSection) }

        let tvSeasonCastListSectionItems: [TVSeasonDetailCellViewModelMultipleSection.SectionItem] = [
            .tvSeasonCastShortList(vm: CreditShortListViewModel(title: title, items: items, creditType: .cast, mediaType: .tvSeason, delegate: self))
        ]

        let tvSeasonCastListSection: TVSeasonDetailCellViewModelMultipleSection =
            .tvSeasonCastShortListSection(title: title, items: tvSeasonCastListSectionItems)

        sections.append(tvSeasonCastListSection)

        return sections
    }
    
    fileprivate func configureTVEpisodeShortListSection(withModel model: TVSeasonDetailModel, sections: [TVSeasonDetailCellViewModelMultipleSection]) -> [TVSeasonDetailCellViewModelMultipleSection] {
        
        var sections = sections
        let limit = 9
        let title = "Список эпизодов"
        
        guard !model.episodes.isEmpty else { return sections }
        let episodeList = model.episodes.prefix(limit)
        
        let episodeSectionItems: [TVEpisodeCellViewModelMultipleSection.SectionItem] =
            episodeList.map { .episode(vm: TVEpisodeCellViewModel($0)) }
        
        let showMoreSectionItems: [TVEpisodeCellViewModelMultipleSection.SectionItem] =
            [.showMore(vm: ShowMoreCellViewModel(title: "Показать еще", type: .tvEpisode))]

        var items = [TVEpisodeCellViewModelMultipleSection.SectionItem]()
        
        items.append(contentsOf: episodeSectionItems)
        if model.episodes.count > limit { items.append(contentsOf: showMoreSectionItems) }

        let tvEpisodeShortListSectionItems: [TVSeasonDetailCellViewModelMultipleSection.SectionItem] = [
            .tvEpisodeShortList(vm: TVEpisodeShortListViewModel(title: title, items: items, mediaID: mediaID, seasonNumber: seasonNumber, coordinator: coordinator))
        ]

        let tvEpisodeShortListSection: TVSeasonDetailCellViewModelMultipleSection =
            .tvEpisodeShortListSection(title: title, items: tvEpisodeShortListSectionItems)

        sections.append(tvEpisodeShortListSection)

        return sections
    }
    
}

extension TVSeasonDetailViewModel: CreditShortListViewModelDelegate {
    
    var creditShortListDelegateCoordinator: ToPeopleRoutable? { coordinator as? ToPeopleRoutable }
    var mediaType: MediaType { .tvSeason }
    var delegateSeasonNumber: String? { seasonNumber }
    var delegateEpisodeNumber: String? { nil }
    
}
