//
//  TVSeasonShortListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 01.05.2021.
//

import Foundation
import RxSwift
import RxRelay

protocol TVSeasonShortListViewModelDelegate: AnyObject {
    var tvSeasonShortListDelegateCoordinator: ToSeasonRoutable? { get }
    var mediaID: String { get }
    func routing(item: TVSeasonCellViewModelMultipleSection.SectionItem)
}

extension TVSeasonShortListViewModelDelegate {
    func routing(item: TVSeasonCellViewModelMultipleSection.SectionItem) {
        guard let coordinator = tvSeasonShortListDelegateCoordinator else { return }
        switch item {
        case .season(let vm):
            coordinator.toSeason(with: mediaID, seasonNumber: vm.seasonNumber)
        case .showMore:
            coordinator.toSeasonList(with: mediaID)
        }
    }
}

class TVSeasonShortListViewModel {
    
//    MARK: - Properties
    let title: String
    let items: [TVSeasonCellViewModelMultipleSection.SectionItem]
    weak var tvSeasonShortListDelegate: TVSeasonShortListViewModelDelegate?
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
    init(title: String, items: [TVSeasonCellViewModelMultipleSection.SectionItem], mediaID: String, delegate: TVSeasonShortListViewModelDelegate?) {
        self.title = title
        self.items = items
        self.tvSeasonShortListDelegate = delegate
        
        subscribe()
    }
    
    fileprivate func subscribe() {
        selectedItem.subscribe(onNext: { [weak self] in
            guard let self = self, let delegate = self.tvSeasonShortListDelegate else { return }
            switch $0 { case .season, .showMore: delegate.routing(item: $0) }
        }).disposed(by: disposeBag)
    }
}
