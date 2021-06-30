//
//  SearchQuickRequestCellModelMultipleSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 26.05.2021.
//

import Foundation
import RxDataSources

enum SearchQuickRequestCellModelMultipleSection {
    
    case categoryListSection(title: String, items: [SectionItem])
    case peopleListSection(title: String, items: [SectionItem])
    case resultSection(title: String, items: [SectionItem])
    
    enum SectionItem: IdentifiableType, Equatable {
        case categoryList(vm: SearchCategoryListViewModel)
        case peopleList(vm: PeopleShortListViewModel)
        case media(vm: MediaCellViewModel)
        case people(vm: PeopleCellViewModel)
        
        var identity: String {
            switch self {
            case .categoryList(let vm): return vm.title
            case .peopleList(let vm): return vm.title
            case .media(let vm): return "\(vm.id)_\(vm.title)"
            case .people(let vm): return "\(vm.id)_\(vm.name)"
            }
        }
        
        static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
            lhs.identity == rhs.identity
        }
    }
    
    init(original: SearchQuickRequestCellModelMultipleSection, items: [SectionItem]) {
        switch original {
        case .categoryListSection(let title, _):
            self = .peopleListSection(title: title, items: items)
        case .peopleListSection(let title, _):
            self = .peopleListSection(title: title, items: items)
        case .resultSection(let title, _):
            self = .resultSection(title: title, items: items)
        }
    }
}

extension SearchQuickRequestCellModelMultipleSection: AnimatableSectionModelType {
    
    var title: String {
        switch self {
        case .categoryListSection(let title, _): return title
        case .peopleListSection(let title, _): return title
        case .resultSection(let title, _): return title
        }
    }
    
    var items: [SectionItem] {
        switch self {
        case .categoryListSection(_, let items): return items
        case .peopleListSection(_, let items): return items
        case .resultSection(_, let items): return items
        }
    }
}

extension SearchQuickRequestCellModelMultipleSection: IdentifiableType {
    var identity: String { return title }
}

extension SearchQuickRequestCellModelMultipleSection: Equatable {
    static func == (lhs: SearchQuickRequestCellModelMultipleSection, rhs: TVEpisodeCellViewModelMultipleSection) -> Bool {
        return lhs.identity == rhs.identity
    }
}
