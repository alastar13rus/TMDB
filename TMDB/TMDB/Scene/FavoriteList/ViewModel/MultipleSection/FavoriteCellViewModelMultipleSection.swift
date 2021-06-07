//
//  FavoriteCellViewModelMultipleSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 07.06.2021.
//

import Foundation
import RxDataSources

enum FavoriteCellViewModelMultipleSection {
    
    case mediaSection(title: String, items: [SectionItem])
    case peopleSection(title: String, items: [SectionItem])
    
    enum SectionItem: IdentifiableType, Equatable {
        case media(vm: MediaCellViewModel)
        case people(vm: PeopleCellViewModel)
        
        var identity: String {
            switch self {
            case .media(let vm): return  vm.id
            case .people(let vm): return vm.id
            }
        }
        
        static func ==(lhs: SectionItem, rhs: SectionItem) -> Bool {
            lhs.identity == rhs.identity
        }
    }
    
    
    init(original: FavoriteCellViewModelMultipleSection, items: [SectionItem]) {
        switch original {
        case .mediaSection(let title, _):
            self = .mediaSection(title: title, items: items)
        case .peopleSection(let title, _):
            self = .peopleSection(title: title, items: items)
        }
    }
}

extension FavoriteCellViewModelMultipleSection: AnimatableSectionModelType {
    
    var title: String {
        switch self {
        case .mediaSection(let title, _): return title
        case .peopleSection(let title, _): return title
        }
    }
    
    var items: [SectionItem] {
        switch self {
        case .mediaSection(_, let items): return items
        case .peopleSection(_, let items): return items
        }
    }
}

extension FavoriteCellViewModelMultipleSection: IdentifiableType {
    var identity: String { return title }
}

extension FavoriteCellViewModelMultipleSection: Equatable {
    static func == (lhs: FavoriteCellViewModelMultipleSection, rhs: FavoriteCellViewModelMultipleSection) -> Bool {
        return lhs.identity == rhs.identity
    }
}

