//
//  TVEpisodeShortListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 04.05.2021.
//

import Foundation
import RxSwift
import RxRelay

class TVEpisodeShortListViewModel {
    
//    MARK: - Properties
    let title: String
    let items: [TVEpisodeCellViewModelMultipleSection.SectionItem]
    let mediaID: String
    let seasonNumber: String
    weak var coordinator: Coordinator?
    let disposeBag = DisposeBag()
    
    
    var sectionedItems: Observable<[TVEpisodeCellViewModelMultipleSection]> {
        
        var episodeSectionItems = [TVEpisodeCellViewModelMultipleSection.SectionItem]()
        var showMoreSectionItems = [TVEpisodeCellViewModelMultipleSection.SectionItem]()
        
        items.forEach {
            if case .episode = $0 { episodeSectionItems.append($0) }
            if case .showMore = $0 { showMoreSectionItems.append($0) }
        }
        
        let episodeSection = TVEpisodeCellViewModelMultipleSection.episodeSection(title: title, items: episodeSectionItems)
        let showMoreSection = TVEpisodeCellViewModelMultipleSection.showMoreSection(title: title, items: showMoreSectionItems)
        
        var sections = [TVEpisodeCellViewModelMultipleSection]()
        sections.append(episodeSection)
        if !showMoreSectionItems.isEmpty { sections.append(showMoreSection) }
        
        return .just(sections)
    }
    
    let selectedItem = PublishRelay<TVEpisodeCellViewModelMultipleSection.SectionItem>()
    
//    MARK: - Init
    init(title: String, items: [TVEpisodeCellViewModelMultipleSection.SectionItem], mediaID: String, seasonNumber: String, coordinator: Coordinator?) {
        self.title = title
        self.items = items
        self.mediaID = mediaID
        self.seasonNumber = seasonNumber
        self.coordinator = coordinator
        
        subscribe()
    }
    
    fileprivate func subscribe() {
        selectedItem.subscribe(onNext: { [weak self] in
            guard let self = self, let coordinator = self.coordinator as? TVSeasonFlowCoordinator else { return }
            switch $0 {
            case .episode(let vm):
                coordinator.toEpisode(with: self.mediaID, seasonNumber: vm.seasonNumber, episodeNumber: vm.episodeNumber)
            case .showMore:
                coordinator.toEpisodeList(with: self.mediaID, seasonNumber: self.seasonNumber)
            }
        }).disposed(by: disposeBag)
    }
}
