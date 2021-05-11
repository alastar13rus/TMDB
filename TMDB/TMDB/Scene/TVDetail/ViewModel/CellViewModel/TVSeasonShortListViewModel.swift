//
//  TVSeasonShortListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 01.05.2021.
//

import Foundation
import RxSwift
import RxRelay

class TVSeasonShortListViewModel {
    
//    MARK: - Properties
    let title: String
    let items: [TVSeasonCellViewModelMultipleSection.SectionItem]
    let mediaID: String
    weak var coordinator: Coordinator?
    let disposeBag = DisposeBag()
    
    
    var sectionedItems: Observable<[TVSeasonCellViewModelMultipleSection]> {
        
        var seasonSectionItems = [TVSeasonCellViewModelMultipleSection.SectionItem]()
        var showMoreSectionItems = [TVSeasonCellViewModelMultipleSection.SectionItem]()
        
        items.forEach {
            if case .season = $0 { seasonSectionItems.append($0) }
            if case .showMore = $0 { showMoreSectionItems.append($0) }
        }
        
        let seasonSection = TVSeasonCellViewModelMultipleSection.seasonSection(title: title, items: seasonSectionItems)
        let showMoreSection = TVSeasonCellViewModelMultipleSection.showMoreSection(title: title, items: showMoreSectionItems)
        
        var sections = [TVSeasonCellViewModelMultipleSection]()
        sections.append(seasonSection)
        if !showMoreSectionItems.isEmpty { sections.append(showMoreSection) }
        
        return .just(sections)
    }
    
    let selectedItem = PublishRelay<TVSeasonCellViewModelMultipleSection.SectionItem>()
    
//    MARK: - Init
    init(title: String, items: [TVSeasonCellViewModelMultipleSection.SectionItem], mediaID: String, coordinator: Coordinator?) {
        self.title = title
        self.items = items
        self.mediaID = mediaID
        self.coordinator = coordinator
        
        subscribe()
    }
    
    fileprivate func subscribe() {
        selectedItem.subscribe(onNext: { [weak self] in
            guard let self = self, let coordinator = self.coordinator as? TVListCoordinator else { return }
            switch $0 {
            case .season(let vm):
                coordinator.toSeason(with: vm.seasonNumber, params: ["mediaID": self.mediaID])
            case .showMore:
                coordinator.toSeasonList(with: self.mediaID)
            }
        }).disposed(by: disposeBag)
    }
}
