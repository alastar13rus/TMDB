//
//  TVDetailViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 08.04.2021.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources

class TVDetailViewModel: DetailViewModelType {
    
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
        let sectionedItems = BehaviorRelay<[TVDetailCellViewModelMultipleSection]>(value: [])
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
        fetch { [weak self] (tvDetail) in
            guard let self = self else { return }
            
            let sections = self.configureSections(from: tvDetail)
            self.output.sectionedItems.accept(sections)
        }
    }
    
    func fetch(completion: @escaping (TVDetailModel) -> Void) {
        self.networkManager.request(TmdbAPI.tv(.details(mediaID: detailID, appendToResponse: [.aggregateCredits, .recommendations, .similar, .images], includeImageLanguage: [.ru, .null]))) { (result: Result<TVDetailModel, Error>) in
            
            switch result {
            case .success(let tvDetail):
                completion(tvDetail)
                
            case .failure(_): break
            }
        }
    }
    
    private func refreshOutput(with section: TVDetailCellViewModelMultipleSection) {
        
        switch section.items[0] {
        case .tvPosterWrapper(let vm):
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
    
    private func configureSections(from model: TVDetailModel) -> [TVDetailCellViewModelMultipleSection] {
        
        let sections = [TVDetailCellViewModelMultipleSection]()
        
        return sections
            .buildSection(withModel: model, andAction: self.configureTVPosterWrapperSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVImageListSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVOverviewSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVRuntimeSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVGenresSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVStatusSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVCrewListSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVCastListSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVCompilationListSection(withModel:sections:mediaListType:), param: MediaListType.recommendation)
            .buildSection(withModel: model, andAction: self.configureTVCompilationListSection(withModel:sections:mediaListType:), param: MediaListType.similar)
        
    }
    
    fileprivate func configureTVPosterWrapperSection(withModel model: TVDetailModel, sections: [TVDetailCellViewModelMultipleSection]) -> [TVDetailCellViewModelMultipleSection] {

        var sections = sections

        let tvPosterWrapperSection: TVDetailCellViewModelMultipleSection =
            .tvPosterWrapperSection(
                title: "Poster",
                items: [.tvPosterWrapper(vm: TVPosterWrapperCellViewModel(model))])

        sections.append(tvPosterWrapperSection)

        refreshOutput(with: tvPosterWrapperSection)

        return sections
    }
    
    fileprivate func configureTVImageListSection(withModel model: TVDetailModel, sections: [TVDetailCellViewModelMultipleSection]) -> [TVDetailCellViewModelMultipleSection] {
        let title = "Фото"
        guard let images = model.images?.backdrops, !images.isEmpty else { return sections }
        var sections = sections
        
        let items: [TVDetailCellViewModelMultipleSection.SectionItem] = [.tvImageList(vm: ImageListViewModel(title: title, items: images.map { ImageCellViewModel($0, imageType: .backdrop(size: .small)) }, coordinator: coordinator, contentForm: .landscape))]
        
        let imageListSection: TVDetailCellViewModelMultipleSection = .tvImageListSection(title: title, items: items)
        
        sections.append(imageListSection)
        return sections
    }
    
    fileprivate func configureTVOverviewSection(withModel model: TVDetailModel, sections: [TVDetailCellViewModelMultipleSection]) -> [TVDetailCellViewModelMultipleSection] {
        
        var sections = sections
        guard !model.overview.isEmpty else { return sections }
        
        let tvOverviewSection: TVDetailCellViewModelMultipleSection =
            .tvPosterWrapperSection(
                title: "Overview",
                items: [.tvOverview(vm: MediaOverviewCellViewModel(model))])
        
        sections.append(tvOverviewSection)
        return sections
    }
    
    fileprivate func configureTVRuntimeSection(withModel model: TVDetailModel, sections: [TVDetailCellViewModelMultipleSection]) -> [TVDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        let tvRuntimeSection: TVDetailCellViewModelMultipleSection =
            .tvRuntimeSection(
                title: "Продолжительность",
                items: [.tvRuntime(vm: TVRuntimeCellViewModel(model))])
        
        sections.append(tvRuntimeSection)
        return sections
    }
    
    fileprivate func configureTVGenresSection(withModel model: TVDetailModel, sections: [TVDetailCellViewModelMultipleSection]) -> [TVDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        let tvGenresSection: TVDetailCellViewModelMultipleSection =
            .tvGenresSection(
                title: "Жанры",
                items: [.tvGenres(vm: GenresCellViewModel(model))])
        
        sections.append(tvGenresSection)
        return sections
    }
    
    fileprivate func configureTVStatusSection(withModel model: TVDetailModel, sections: [TVDetailCellViewModelMultipleSection]) -> [TVDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        let tvStatusSection: TVDetailCellViewModelMultipleSection =
            .tvStatusSection(
                title: "Статус",
                items: [.tvStatus(vm: MediaStatusCellViewModel(model))])
        
        sections.append(tvStatusSection)
        return sections
    }
    
    fileprivate func configureTVCrewListSection(withModel model: TVDetailModel, sections: [TVDetailCellViewModelMultipleSection]) -> [TVDetailCellViewModelMultipleSection] {
        
        var sections = sections
        let crewCount = model.aggregateCredits?.crew.count ?? 0
        let limit = 10
        let title = "Съемочная группа"
        
        guard let crewList = model.aggregateCredits?.crew.sorted(by: >).prefix(limit), !crewList.isEmpty else { return sections }
        
        
        let crewSection: [CreditCellViewModelMultipleSection.SectionItem] =
            crewList.map { .tvAggregateCrew(vm: TVAggregateCrewCellViewModel($0)) }
        
        let showMoreSection: [CreditCellViewModelMultipleSection.SectionItem] =
            [.showMore(vm: ShowMoreCellViewModel(title: "Показать еще", type: .crew))]

        var items = [CreditCellViewModelMultipleSection.SectionItem]()
        items.append(contentsOf: crewSection)
        if crewCount > limit { items.append(contentsOf: showMoreSection) }

        let tvCrewListSectionItems: [TVDetailCellViewModelMultipleSection.SectionItem] = [
            .tvCrewList(vm: CreditShortListViewModel(title: title, items: items, coordinator: coordinator, networkManager: networkManager, mediaID: detailID, creditType: .crew))
        ]

        let tvCrewListSection: TVDetailCellViewModelMultipleSection =
            .tvCrewListSection(title: title, items: tvCrewListSectionItems)

        sections.append(tvCrewListSection)

        return sections
    }
    
    fileprivate func configureTVCastListSection(withModel model: TVDetailModel, sections: [TVDetailCellViewModelMultipleSection]) -> [TVDetailCellViewModelMultipleSection] {
        
        var sections = sections
        let castCount = model.aggregateCredits?.cast.count ?? 0
        let limit = 10
        let title = "Актеры"
        
        guard let castList = model.aggregateCredits?.cast.sorted(by: >).prefix(limit), !castList.isEmpty else { return sections }
        
        
        let castSection: [CreditCellViewModelMultipleSection.SectionItem] =
            castList.map { .tvAggregateCast(vm: TVAggregateCastCellViewModel($0)) }
        
        let showMoreSection: [CreditCellViewModelMultipleSection.SectionItem] =
            [.showMore(vm: ShowMoreCellViewModel(title: "Показать еще", type: .cast))]

        var items = [CreditCellViewModelMultipleSection.SectionItem]()
        items.append(contentsOf: castSection)
        if castCount > limit { items.append(contentsOf: showMoreSection) }

        let tvCastListSectionItems: [TVDetailCellViewModelMultipleSection.SectionItem] = [
            .tvCastList(vm: CreditShortListViewModel(title: title, items: items, coordinator: coordinator, networkManager: networkManager, mediaID: detailID, creditType: .cast))
        ]

        let tvCastListSection: TVDetailCellViewModelMultipleSection =
            .tvCrewListSection(title: title, items: tvCastListSectionItems)

        sections.append(tvCastListSection)

        return sections
    }
    
    fileprivate func configureTVCompilationListSection(withModel model: TVDetailModel, sections: [TVDetailCellViewModelMultipleSection], mediaListType: MediaListType) -> [TVDetailCellViewModelMultipleSection] {
        
        var sections = sections
        let limit = 10
        let title = mediaListType.title
        var tvList = [TVModel]()
        
        switch mediaListType {
        case .recommendation:
            guard let list = model.recommendations?.results.prefix(limit), !list.isEmpty else { return sections }
            tvList = Array(list)
        case .similar:
            guard let list = model.similar?.results.prefix(limit), !list.isEmpty else { return sections }
            tvList = Array(list)
        }
        
        let section: [MediaCellViewModel] = tvList.map { MediaCellViewModel($0) }
        
        let tvListSectionItems: [TVDetailCellViewModelMultipleSection.SectionItem] = [
            .tvCompilationList(vm: MediaCompilationListViewModel(title: title, items: section, coordinator: coordinator, networkManager: networkManager, mediaListType: mediaListType))
        ]
        
        let tvListSection: TVDetailCellViewModelMultipleSection =
            .tvCompilationListSection(title: title, items: tvListSectionItems)
        
        sections.append(tvListSection)
        
        return sections
    }
    
}
