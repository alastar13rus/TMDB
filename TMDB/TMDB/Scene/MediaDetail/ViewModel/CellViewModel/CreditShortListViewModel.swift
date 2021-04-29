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

class CreditShortListViewModel: AnimatableSectionModelType, IdentifiableType {

    var identity: String { return title }
    let title: String
    let items: [CreditCellViewModelMultipleSection.SectionItem]
    weak var coordinator: Coordinator?
    var networkManager: NetworkManagerProtocol?
    var mediaID = ""
    var creditType: CreditType = .cast
    let disposeBag = DisposeBag()

    var sectionedItems: Observable<[CreditCellViewModelMultipleSection]> {
        
        var castItems = [CreditCellViewModelMultipleSection.SectionItem]()
        var crewItems = [CreditCellViewModelMultipleSection.SectionItem]()
        var showMoreItems = [CreditCellViewModelMultipleSection.SectionItem]()
        items.forEach {
            switch $0 {
            case .cast, .tvAggregateCast: castItems.append($0)
            case .crew, .tvAggregateCrew: crewItems.append($0)
            case .showMore: showMoreItems.append($0)
            }
        }
        let castSection: CreditCellViewModelMultipleSection = .castSection(title: title, items: castItems)
        let crewSection: CreditCellViewModelMultipleSection = .crewSection(title: title, items: crewItems)
        let showMoreSection: CreditCellViewModelMultipleSection = .showMoreSection(title: title, items: showMoreItems)
        
        switch creditType {
        case .cast: return .just([castSection, showMoreSection])
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
    
    convenience init(title: String, items: [CreditCellViewModelMultipleSection.SectionItem], coordinator: Coordinator?, networkManager: NetworkManagerProtocol?, mediaID: String, creditType: CreditType) {
        self.init(title: title, items: items)
        self.coordinator = coordinator
        self.mediaID = mediaID
        self.creditType = creditType
        self.networkManager = networkManager
        
        subscribing()
    }
    
//    MARK: - Methods
    fileprivate func subscribing() {
        self.selectedItem.subscribe(onNext: {  [weak self] in
            guard let self = self else { return }
            if let coordinator = self.coordinator as? MovieListCoordinator {
                self.routingWithMovieCoordinator(coordinator: coordinator, item: $0)
            } else if let coordinator = self.coordinator as? TVListCoordinator {
                self.routingWithTVCoordinator(coordinator: coordinator, item: $0)
            } else {
                return
            }
            
        }).disposed(by: disposeBag)
    }
    
    fileprivate func routingWithMovieCoordinator(coordinator: MovieListCoordinator, item: CreditCellViewModelMultipleSection.SectionItem) {
        switch item {
        case .cast(let vm):
            coordinator.toPeople(with: vm.id)
        case .crew(let vm):
            coordinator.toPeople(with: vm.id)
        case .showMore(let vm):
            coordinator.toCreditList(
                with: self.mediaID,
                params: [
                    String(describing: CreditType.self): vm.type.rawValue,
                    String(describing: MediaType.self): MediaType.movie.rawValue,
                    String(describing: Coordinator.self): String(describing: MovieListCoordinator.self)
                ])
        default: break
        }
    }
    
    fileprivate func routingWithTVCoordinator(coordinator: TVListCoordinator, item: CreditCellViewModelMultipleSection.SectionItem) {
        switch item {
        case .cast(let vm):
            coordinator.toPeople(with: vm.id)
        case .tvAggregateCast(let vm):
            coordinator.toPeople(with: vm.id)
        case .crew(let vm):
            coordinator.toPeople(with: vm.id)
        case .tvAggregateCrew(let vm):
            coordinator.toPeople(with: vm.id)
        case .showMore(let vm):
            coordinator.toCreditList(
                with: self.mediaID,
                params: [
                    String(describing: CreditType.self): vm.type.rawValue,
                    String(describing: MediaType.self): MediaType.tv.rawValue,
                    String(describing: Coordinator.self): String(describing: TVListCoordinator.self)
                ])
        }
    }
    
//    fileprivate func fetchPeopleID(with creditID: String, completion: @escaping (String) -> Void) {
//            networkManager?.request(TmdbAPI.credit(.details(creditID: creditID)), completion: { (result: Result<CreditDetailModel, Error>) in
//                switch result {
//                case .success(let creditDetail):
//                    let peopleID = "\(creditDetail.person.id)"
//                    completion(peopleID)
//                case .failure: break
//                }
//            })
//    }
    
}
