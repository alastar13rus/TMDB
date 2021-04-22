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
        self.networkManager.request(TmdbAPI.tv(.details(mediaID: detailID, appendToResponse: [.credits]))) { (result: Result<TVDetailModel, Error>) in
            
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
            .buildSection(withModel: model, andAction: self.configureTVOverviewSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVRuntimeSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVGenresSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVStatusSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVCrewListSection(withModel:sections:))
            .buildSection(withModel: model, andAction: self.configureTVCastListSection(withModel:sections:))
        
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

    
    fileprivate func configureTVOverviewSection(withModel model: TVDetailModel, sections: [TVDetailCellViewModelMultipleSection]) -> [TVDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
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
        
        
        if let crewList = model.credits?.crew.filter { $0.profilePath != nil }.toUnique().prefix(10), !crewList.isEmpty {
            let title = "Создатели"
            
            let crewSection: [CreditCellViewModelMultipleSection.SectionItem] =
                crewList.map { .crew(vm: CrewCellViewModel($0)) }
            
            let showMoreSection: [CreditCellViewModelMultipleSection.SectionItem] =
                [.showMore(vm: ShowMoreCellViewModel(title: "Показать еще", type: .crew))]
            
            let items: [TVDetailCellViewModelMultipleSection.SectionItem] = [
                .tvCrewList(vm: CreditShortListViewModel(title: title, items: crewSection + showMoreSection, coordinator: coordinator, networkManager: networkManager, mediaID: detailID, creditType: .crew))
            ]
            
            let tvCrewListSection: TVDetailCellViewModelMultipleSection =
                .tvCrewListSection(title: title, items: items)
            
            sections.append(tvCrewListSection)
        }
        return sections
    }
    
    fileprivate func configureTVCastListSection(withModel model: TVDetailModel, sections: [TVDetailCellViewModelMultipleSection]) -> [TVDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        if let castList = model.credits?.cast.prefix(10), !castList.isEmpty {
            let title = "Актеры"
            
            let castSection: [CreditCellViewModelMultipleSection.SectionItem] =
                castList.map { .cast(vm: CastCellViewModel($0)) }
            
            let showMoreSection: [CreditCellViewModelMultipleSection.SectionItem] =
                [.showMore(vm: ShowMoreCellViewModel(title: "Показать еще", type: .cast))]
            
            let items: [TVDetailCellViewModelMultipleSection.SectionItem] = [
                .tvCastList(vm: CreditShortListViewModel(title: title, items: castSection + showMoreSection, coordinator: coordinator, networkManager: networkManager, mediaID: detailID, creditType: .cast))
            ]
            
            let tvCastListSection: TVDetailCellViewModelMultipleSection =
                .tvCastListSection(title: title, items: items)
            
            sections.append(tvCastListSection)
        }
        return sections
    }
    
}
