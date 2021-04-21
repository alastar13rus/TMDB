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

class PeopleBestMediaListViewModel: AnimatableSectionModelType {
    
    //    MARK: - Properties
    let title: String
    let items: [CreditInMediaCellViewModelMultipleSection.SectionItem]
    weak var coordinator: Coordinator?
    let dataSource = BestCreditInMediaListDataSource.dataSource()
    
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
        
        return .just([movieSection, tvSection])
                     
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
