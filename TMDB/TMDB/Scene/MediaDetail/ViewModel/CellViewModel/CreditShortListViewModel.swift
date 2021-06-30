//
//  CreditShortListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources
import Domain

protocol CreditShortListViewModelDelegate: AnyObject {
    var creditShortListDelegateCoordinator: ToPeopleRoutable? { get }
    var mediaID: String { get }
    var mediaType: MediaType { get }
    var delegateSeasonNumber: String? { get }
    var delegateEpisodeNumber: String? { get }
    func routing(item: CreditCellViewModelMultipleSection.SectionItem, creditType: CreditType)
}

extension CreditShortListViewModelDelegate {
    func routing(item: CreditCellViewModelMultipleSection.SectionItem, creditType: CreditType) {
        guard let coordinator = creditShortListDelegateCoordinator else { return }
        switch item {
        case .cast(let vm):
            coordinator.toPeople(with: vm.id)
        case .aggregateCast(let vm):
            coordinator.toPeople(with: vm.id)
        case .crew(let vm):
            coordinator.toPeople(with: vm.id)
        case .aggregateCrew(let vm):
            coordinator.toPeople(with: vm.id)
        case .showMore:
            switch coordinator {
            case is MovieFlowCoordinator: coordinator.toCreditList(with: mediaID,
                                                                   mediaType: mediaType,
                                                                   creditType: creditType,
                                                                   seasonNumber: nil,
                                                                   episodeNumber: nil)
            case is TVFlowCoordinator: coordinator.toCreditList(with: mediaID,
                                                                mediaType: mediaType,
                                                                creditType: creditType,
                                                                seasonNumber: nil,
                                                                episodeNumber: nil)
            case is TVSeasonFlowCoordinator:
                guard let seasonNumber = delegateSeasonNumber else { return }
                coordinator.toCreditList(with: mediaID,
                                         mediaType: mediaType,
                                         creditType: creditType,
                                         seasonNumber: seasonNumber, episodeNumber: nil)
            case is TVEpisodeFlowCoordinator:
                guard let seasonNumber = delegateSeasonNumber, let episodeNumber = delegateEpisodeNumber else { return }
                coordinator.toCreditList(with: mediaID,
                                         mediaType: mediaType,
                                         creditType: creditType,
                                         seasonNumber: seasonNumber, episodeNumber: episodeNumber)
            default: break
            }
        }
    }
}

class CreditShortListViewModel: AnimatableSectionModelType, IdentifiableType {

    var identity: String { return title }
    let title: String
    let items: [CreditCellViewModelMultipleSection.SectionItem]
    weak var delegate: CreditShortListViewModelDelegate?
    var creditType: CreditType = .cast
    let disposeBag = DisposeBag()

    var sectionedItems: Observable<[CreditCellViewModelMultipleSection]> {
        
        var castItems = [CreditCellViewModelMultipleSection.SectionItem]()
        var crewItems = [CreditCellViewModelMultipleSection.SectionItem]()
        var showMoreItems = [CreditCellViewModelMultipleSection.SectionItem]()
        items.forEach {
            switch $0 {
            case .cast, .aggregateCast: castItems.append($0)
            case .crew, .aggregateCrew: crewItems.append($0)
            case .showMore: showMoreItems.append($0)
            }
        }
        let castSection: CreditCellViewModelMultipleSection = .castSection(title: title, items: castItems)
        let crewSection: CreditCellViewModelMultipleSection = .crewSection(title: title, items: crewItems)
        let showMoreSection: CreditCellViewModelMultipleSection = .showMoreSection(title: title, items: showMoreItems)
        
        switch creditType {
        case .cast: return .just([castSection, showMoreSection])
        case .guestStars: return .just([castSection, showMoreSection])
        case .crew: return .just([crewSection, showMoreSection])
        }
        
    }
    
    var selectedItem = PublishRelay<CreditCellViewModelMultipleSection.SectionItem>()

    required init(original: CreditShortListViewModel, items: [CreditCellViewModelMultipleSection.SectionItem]) {
        self.title = original.title
        self.items = items
    }
    
    init(title: String, items: [CreditCellViewModelMultipleSection.SectionItem]) {
        self.title = title
        self.items = items
    }
    
// MARK: - Methods
    fileprivate func subscribing() {
        self.selectedItem.subscribe(onNext: {  [weak self] in
            guard let self = self, let delegate = self.delegate else { return }
            delegate.routing(item: $0, creditType: self.creditType)
        }).disposed(by: disposeBag)
    }
}

extension CreditShortListViewModel {
    
    convenience init(title: String,
                     items: [CreditCellViewModelMultipleSection.SectionItem],
                     creditType: CreditType, mediaType: MediaType,
                     delegate: CreditShortListViewModelDelegate?) {
        
        self.init(title: title, items: items)
        self.delegate = delegate
        self.creditType = creditType

        subscribing()
    }
}
