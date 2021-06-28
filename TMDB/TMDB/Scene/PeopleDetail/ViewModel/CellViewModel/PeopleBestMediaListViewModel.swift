//
//  PeopleBestMediaCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.04.2021.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources
import Domain

class PeopleBestMediaListViewModel: AnimatableSectionModelType {
    
    //    MARK: - Properties
    let title: String
    let items: [CreditInMediaCellViewModelMultipleSection.SectionItem]
    
    weak var coordinator: Coordinator?
    
    let dataSource = BestCreditInMediaListDataSource.dataSource()
    let disposeBag = DisposeBag()
    let selectedCredit = PublishRelay<CreditInMediaCellViewModelMultipleSection.SectionItem>()
    
    var sectionedItems: Observable<[CreditInMediaCellViewModelMultipleSection]> {
        
        var movieItems = [CreditInMediaCellViewModelMultipleSection.SectionItem]()
        var tvItems = [CreditInMediaCellViewModelMultipleSection.SectionItem]()
        
        items.forEach {
            switch $0 {
            case .creditInMovie: movieItems.append($0)
            case .creditInTV: tvItems.append($0)
            }
        }
        let movieSection: CreditInMediaCellViewModelMultipleSection = .creditInMovieSection(title: "Фильмы", items: movieItems)
        let tvSection: CreditInMediaCellViewModelMultipleSection = .creditInTVSection(title: "Сериалы", items: tvItems)
        
        var sections = [CreditInMediaCellViewModelMultipleSection]()
        if !movieItems.isEmpty { sections.append(movieSection) }
        if !tvItems.isEmpty { sections.append(tvSection) }
        
        return .just(sections)
                     
        }
        
    //    MARK: - Init
    required init(original: PeopleBestMediaListViewModel, items: [CreditInMediaCellViewModelMultipleSection.SectionItem]) {
        self.title = original.title
        self.items = items
    }
    
    init(title: String, items: [CreditInMediaCellViewModelMultipleSection.SectionItem]) {
        self.title = title
        self.items = items
    }
    
    convenience init(title: String, items: [CreditInMediaCellViewModelMultipleSection.SectionItem], coordinator: Coordinator?) {
        self.init(title: title, items: items)
        self.coordinator = coordinator
        
        subscribing()
    }
    
//    MARK: - Methods
    fileprivate func subscribing() {
        self.selectedCredit.subscribe(onNext: { [weak self] in
            guard let self = self, let coordinator = self.coordinator as? PeopleFlowCoordinator else { return }
            switch $0 {
            case .creditInMovie(let vm):
                coordinator.toMovieDetail(with: vm.id)
            case .creditInTV(let vm):
                coordinator.toTVDetail(with: vm.id)
            }
        }).disposed(by: disposeBag)
    }
    
    
}

extension PeopleBestMediaListViewModel: IdentifiableType {
    var identity: String { return title }
}

extension PeopleBestMediaListViewModel: Equatable {
    static func ==(lhs: PeopleBestMediaListViewModel, rhs: PeopleBestMediaListViewModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}
