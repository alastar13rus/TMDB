//
//  TVEpisodeDetailViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.05.2021.
//

import Foundation
import RxSwift
import RxRelay
import Swinject
import Domain
import NetworkPlatform

class TVEpisodeDetailViewModel {
    
//    MARK: - Properties
    let mediaID: String
    let seasonNumber: String
    let episodeNumber: String

    let useCaseProvider: Domain.UseCaseProvider
    private let networkMonitor: Domain.NetworkMonitor
    
    weak var coordinator: Coordinator?
    let disposeBag = DisposeBag()
    
    let input = Input()
    let output = Output()
    
    struct Input {
        let selectedItem = PublishRelay<TVEpisodeDetailCellViewModelMultipleSection.SectionItem>()
    }
    
    struct Output {
        let title = BehaviorRelay<String>(value: "")
        let stillImageData = BehaviorRelay<Data?>(value: nil)
        let sectionedItems = BehaviorRelay<[TVEpisodeDetailCellViewModelMultipleSection]>(value: [])
    }
    
    
    
    
//    MARK: - Init
    required init(with mediaID: String,
                  seasonNumber: String,
                  episodeNumber: String,
                  useCaseProvider: Domain.UseCaseProvider,
                  networkMonitor: Domain.NetworkMonitor) {
        self.mediaID = mediaID
        self.seasonNumber = seasonNumber
        self.episodeNumber = episodeNumber
        
        self.useCaseProvider = useCaseProvider
        self.networkMonitor = networkMonitor

        setupInput()
        setupOutput()
    }
    
    
//    MARK: - Methods
    fileprivate func setupInput() {
        input.selectedItem.subscribe(onNext: { [weak self] in
            guard let self = self, let coordinator = self.coordinator as? TVEpisodeFlowCoordinator else { return }
            if case .tvEpisodeTrailerButton = $0 {
                coordinator.toTrailerList(with: self.mediaID, mediaType: .tvEpisode, seasonNumber: self.seasonNumber, episodeNumber: self.episodeNumber)
            }
        }).disposed(by: disposeBag)
    }
    
    fileprivate func setupOutput() {
        fetch { [weak self] (tvEpisodeDetail) in
            guard let self = self else { return }
            let sections = self.configureSections(from: tvEpisodeDetail)
            self.output.sectionedItems.accept(sections)
        }
    }
    
    fileprivate func fetch(completion: @escaping (TVEpisodeDetailModel) -> Void) {
        
        let useCase = useCaseProvider.makeTVEpisodeDetailUseCase()
        useCase.details(mediaID: mediaID, seasonNumber: seasonNumber, episodeNumber: episodeNumber, appendToResponse: [.credits, .images, .videos], includeImageLanguage: []) { [weak self] (result: Result<TVEpisodeDetailModel, Error>) in
            switch result {
            case .success(let tvEpisodeDetail):
                completion(tvEpisodeDetail)
                
            case .failure(let error):
                self?.inform(with: error.localizedDescription)
            }
        }
    }
    
    private func refreshOutput(with section: TVEpisodeDetailCellViewModelMultipleSection) {
        
        switch section.items[0] {
        case .tvEpisodeStillWrapper(let vm):
            self.output.title.accept(vm.name)
        default: break
        }
    }
    
    fileprivate func configureSections(from model: TVEpisodeDetailModel) -> [TVEpisodeDetailCellViewModelMultipleSection] {
        
        let sections = [TVDetailCellViewModelMultipleSection]()
        
        return sections
            .buildSection(withModel: model, andAction: self.configureTVEpisodeStillWrapperSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVEpisodeImageListSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVEpisodeTrailerButtonSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVEpisodeOverviewSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVEpisodeCrewListSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVEpisodeCastListSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVEpisodeGuestStarsListSection(withModel:sections:))

    }
    
    fileprivate func configureTVEpisodeStillWrapperSection(withModel model: TVEpisodeDetailModel, sections: [TVEpisodeDetailCellViewModelMultipleSection]) -> [TVEpisodeDetailCellViewModelMultipleSection] {
    
            var sections = sections

            let tvEpisodeStillWrapperSection: TVEpisodeDetailCellViewModelMultipleSection =
                .tvEpisodeStillWrapperSection(
                    title: "Still",
                    items: [.tvEpisodeStillWrapper(vm: TVEpisodeStillWrapperCellViewModel(model))])

            sections.append(tvEpisodeStillWrapperSection)

            refreshOutput(with: tvEpisodeStillWrapperSection)

            return sections
        }
    
    fileprivate func configureTVEpisodeImageListSection(withModel model: TVEpisodeDetailModel, sections: [TVEpisodeDetailCellViewModelMultipleSection]) -> [TVEpisodeDetailCellViewModelMultipleSection] {
        let title = "Фото"
        
        guard var images = model.images?.stills, !images.isEmpty else { return sections }
        images.removeFirst()
        guard !images.isEmpty else { return sections }
        
        var sections = sections
        
        guard let coordinator = coordinator as? ToImageFullScreenRoutable else { return sections }
        
        let items: [TVEpisodeDetailCellViewModelMultipleSection.SectionItem] = [.tvEpisodeImageList(vm: ImageListViewModel(title: title, items: images.map { ImageCellViewModel($0, imageType: .still(size: .small)) }, coordinator: coordinator, contentForm: .landscape))]
        
        let imageListSection: TVEpisodeDetailCellViewModelMultipleSection = .tvEpisodeImageListSection(title: title, items: items)
        
        sections.append(imageListSection)
        return sections
    }
    
    fileprivate func configureTVEpisodeTrailerButtonSection(withModel model: TVEpisodeDetailModel, sections: [TVEpisodeDetailCellViewModelMultipleSection]) -> [TVEpisodeDetailCellViewModelMultipleSection] {
        let title = "Смотреть трейлеры"
        guard let videos = model.videos?.results, !videos.isEmpty else { return sections }
        var sections = sections

        let items: [TVEpisodeDetailCellViewModelMultipleSection.SectionItem] = [
            .tvEpisodeTrailerButton(vm: ButtonCellViewModel(title: title, type: .trailer))
        ]

        let trailerSection: TVEpisodeDetailCellViewModelMultipleSection = .tvEpisodeTrailerButtonSection(title: title, items: items)

        sections.append(trailerSection)
        return sections
    }
    
    fileprivate func configureTVEpisodeOverviewSection(withModel model: TVEpisodeDetailModel, sections: [TVEpisodeDetailCellViewModelMultipleSection]) -> [TVEpisodeDetailCellViewModelMultipleSection] {
        
        var sections = sections
        guard !model.overview.isEmpty else { return sections }
        
        let tvEpisodeOverviewSection: TVEpisodeDetailCellViewModelMultipleSection =
            .tvEpisodeOverviewSection(
                title: "Overview",
                items: [.tvEpisodeOverview(vm: TVEpisodeOverviewCellViewModel(model))])
        
        sections.append(tvEpisodeOverviewSection)
        return sections
    }
    
    fileprivate func configureTVEpisodeCrewListSection(withModel model: TVEpisodeDetailModel, sections: [TVEpisodeDetailCellViewModelMultipleSection]) -> [TVEpisodeDetailCellViewModelMultipleSection] {
        
        var sections = sections
        let crewCount = model.credits?.crew.count ?? 0
        let limit = 10
        let title = "Съемочная группа"
        
        guard let crewList = model.credits?.crew.sorted(by: >).prefix(limit), !crewList.isEmpty else { return sections }
        
        
        let crewSection: [CreditCellViewModelMultipleSection.SectionItem] =
            crewList.map { .crew(vm: CrewCellViewModel($0)) }
        
        let showMoreSection: [CreditCellViewModelMultipleSection.SectionItem] =
            [.showMore(vm: ShowMoreCellViewModel(title: "Показать еще", type: .crew))]

        var items = [CreditCellViewModelMultipleSection.SectionItem]()
        items.append(contentsOf: crewSection)
        if crewCount > limit { items.append(contentsOf: showMoreSection) }

        let tvEpisodeCrewListSectionItems: [TVEpisodeDetailCellViewModelMultipleSection.SectionItem] = [
            .tvEpisodeCrewShortList(vm: CreditShortListViewModel(title: title, items: items, creditType: .crew, mediaType: .tvEpisode, delegate: self))
        ]

        let tvEpisodeCrewListSection: TVEpisodeDetailCellViewModelMultipleSection =
            .tvEpisodeCrewShortListSection(title: title, items: tvEpisodeCrewListSectionItems)

        sections.append(tvEpisodeCrewListSection)

        return sections
    }
    
    fileprivate func configureTVEpisodeCastListSection(withModel model: TVEpisodeDetailModel, sections: [TVEpisodeDetailCellViewModelMultipleSection]) -> [TVEpisodeDetailCellViewModelMultipleSection] {
        
        var sections = sections
        let castCount = model.credits?.cast.count ?? 0
        let limit = 10
        let title = "Актеры"
        
        guard let castList = model.credits?.cast.sorted(by: >).prefix(limit), !castList.isEmpty else { return sections }
        
        
        let castSection: [CreditCellViewModelMultipleSection.SectionItem] =
            castList.map { .cast(vm: CastCellViewModel($0)) }
        
        let showMoreSection: [CreditCellViewModelMultipleSection.SectionItem] =
            [.showMore(vm: ShowMoreCellViewModel(title: "Показать еще", type: .cast))]

        var items = [CreditCellViewModelMultipleSection.SectionItem]()
        items.append(contentsOf: castSection)
        if castCount > limit { items.append(contentsOf: showMoreSection) }

        let tvEpisodeCastListSectionItems: [TVEpisodeDetailCellViewModelMultipleSection.SectionItem] = [
            .tvEpisodeCastShortList(vm: CreditShortListViewModel(title: title, items: items,  creditType: .cast, mediaType: .tvEpisode, delegate: self))
        ]

        let tvEpisodeCastListSection: TVEpisodeDetailCellViewModelMultipleSection =
            .tvEpisodeCastShortListSection(title: title, items: tvEpisodeCastListSectionItems)

        sections.append(tvEpisodeCastListSection)

        return sections
    }
    
    fileprivate func configureTVEpisodeGuestStarsListSection(withModel model: TVEpisodeDetailModel, sections: [TVEpisodeDetailCellViewModelMultipleSection]) -> [TVEpisodeDetailCellViewModelMultipleSection] {
        
        var sections = sections
        let guestStarsCount = model.credits?.guestStars.count ?? 0
        let limit = 10
        let title = "Приглашенные звезды"
        
        guard let guestStarsList = model.credits?.guestStars.sorted(by: >).prefix(limit), !guestStarsList.isEmpty else { return sections }
        
        
        let guestStarsSection: [CreditCellViewModelMultipleSection.SectionItem] =
            guestStarsList.map { .cast(vm: CastCellViewModel($0)) }
        
        let showMoreSection: [CreditCellViewModelMultipleSection.SectionItem] =
            [.showMore(vm: ShowMoreCellViewModel(title: "Показать еще", type: .cast))]

        var items = [CreditCellViewModelMultipleSection.SectionItem]()
        items.append(contentsOf: guestStarsSection)
        if guestStarsCount > limit { items.append(contentsOf: showMoreSection) }

        let tvEpisodeGuestStarsListSectionItems: [TVEpisodeDetailCellViewModelMultipleSection.SectionItem] = [
            .tvEpisodeGuestStarsShortList(vm: CreditShortListViewModel(title: title, items: items, creditType: .guestStars, mediaType: .tvEpisode,  delegate: self))
        ]

        let tvEpisodeGuestStarsListSection: TVEpisodeDetailCellViewModelMultipleSection =
            .tvEpisodeCastShortListSection(title: title, items: tvEpisodeGuestStarsListSectionItems)

        sections.append(tvEpisodeGuestStarsListSection)

        return sections
    }
    
    private func inform(with message: String) {
        networkMonitor.delegate?.inform(with: message)
    }
    
}

extension TVEpisodeDetailViewModel: CreditShortListViewModelDelegate {
    var creditShortListDelegateCoordinator: ToPeopleRoutable? { coordinator as? ToPeopleRoutable }
    
    var mediaType: MediaType { MediaType.tvEpisode }
    var delegateSeasonNumber: String? { seasonNumber }
    var delegateEpisodeNumber: String? { episodeNumber }
}
