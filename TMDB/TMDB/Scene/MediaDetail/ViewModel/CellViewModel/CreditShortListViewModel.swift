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
    var seasonNumber = ""
    var episodeNumber = ""
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
    
//    MARK: - Methods
    fileprivate func subscribing() {
        self.selectedItem.subscribe(onNext: {  [weak self] in
            guard let self = self else { return }
            
            switch self.coordinator {
            case let coordinator as MovieListCoordinator:
                self.routingWithCoordinator(coordinator: coordinator, item: $0)
                
            case let coordinator as TVListCoordinator:
                self.routingWithCoordinator(coordinator: coordinator, item: $0)
                
            case let coordinator as TVSeasonListCoordinator:
                self.routingWithCoordinator(coordinator: coordinator, item: $0)
                
            case let coordinator as TVEpisodeListCoordinator:
                self.routingWithCoordinator(coordinator: coordinator, item: $0)
                
            default: break
            }
            
            
        }).disposed(by: disposeBag)
    }
}

//  MARK: - extension
extension CreditShortListViewModel {
    
    fileprivate func routingWithCoordinator<T: ToPeopleRoutable>(coordinator: T, item: CreditCellViewModelMultipleSection.SectionItem) {
        switch item {
        case .cast(let vm):
            coordinator.toPeople(with: vm.id)
        case .aggregateCast(let vm):
            coordinator.toPeople(with: vm.id)
        case .crew(let vm):
            coordinator.toPeople(with: vm.id)
        case .aggregateCrew(let vm):
            coordinator.toPeople(with: vm.id)
        case .showMore(let vm):
            var params: [String: String] = [
                String(describing: CreditType.self): vm.type.rawValue,
                String(describing: Coordinator.self): String(describing: T.self)
            ]
            
            switch coordinator {
            case is MovieListCoordinator:
                params[String(describing: MediaType.self)] = MediaType.movie.rawValue
            case is TVListCoordinator:
                params[String(describing: MediaType.self)] = MediaType.tv.rawValue
            case is TVSeasonListCoordinator:
                params[String(describing: MediaType.self)] = MediaType.tv.rawValue
                params["seasonNumber"] = seasonNumber
            default: break
            }
            
            coordinator.toCreditList( with: self.mediaID, params: params)
        }
    }
    
}

extension CreditShortListViewModel {
    
    convenience init(title: String, items: [CreditCellViewModelMultipleSection.SectionItem], coordinator: Coordinator?, networkManager: NetworkManagerProtocol?, mediaID: String, creditType: CreditType) {
        self.init(title: title, items: items)
        self.coordinator = coordinator
        self.mediaID = mediaID
        self.creditType = creditType
        self.networkManager = networkManager
        
        subscribing()
    }
}

extension CreditShortListViewModel {
    
    convenience init(title: String, items: [CreditCellViewModelMultipleSection.SectionItem], coordinator: Coordinator?, networkManager: NetworkManagerProtocol?, mediaID: String, seasonNumber: String, creditType: CreditType) {
        self.init(title: title, items: items)
        self.coordinator = coordinator
        self.mediaID = mediaID
        self.seasonNumber = seasonNumber
        self.creditType = creditType
        self.networkManager = networkManager
        
        subscribing()
    }
}

extension CreditShortListViewModel {
    
    convenience init(title: String, items: [CreditCellViewModelMultipleSection.SectionItem], coordinator: Coordinator?, networkManager: NetworkManagerProtocol?, mediaID: String, seasonNumber: String, episodeNumber: String, creditType: CreditType) {
        self.init(title: title, items: items)
        self.coordinator = coordinator
        self.mediaID = mediaID
        self.seasonNumber = seasonNumber
        self.episodeNumber = episodeNumber
        self.creditType = creditType
        self.networkManager = networkManager
        
        subscribing()
    }
}
