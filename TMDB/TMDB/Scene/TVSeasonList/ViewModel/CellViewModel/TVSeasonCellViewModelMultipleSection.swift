//
//  TVSeasonCellViewModelMultipleSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 01.05.2021.
//

import Foundation
import RxDataSources

enum TVSeasonCellViewModelMultipleSection {
    
    case seasonSection(title: String, items: [SectionItem])
    case showMoreSection(title: String, items: [SectionItem])
    
    enum SectionItem: IdentifiableType, Equatable {
        case season(vm: TVSeasonCellViewModel)
        case showMore(vm: ShowMoreCellViewModel)
        
        var identity: String {
            switch self {
            case .season(let vm): return vm.id
            case .showMore(let vm): return vm.type.rawValue
            }
        }
    }
    
    
    init(original: TVSeasonCellViewModelMultipleSection, items: [SectionItem]) {
        switch original {
        case .seasonSection(let title, _):
            self = .seasonSection(title: title, items: items)
        case .showMoreSection(let title, _):
            self = .showMoreSection(title: title, items: items)
        }
    }
}

extension TVSeasonCellViewModelMultipleSection: AnimatableSectionModelType {
    
    var title: String {
        switch self {
        case .seasonSection(let title, _): return title
        case .showMoreSection(let title, _): return title
        }
    }
    
    var items: [SectionItem] {
        switch self {
        case .seasonSection(_, let items): return items
        case .showMoreSection(_, let items): return items
        }
    }
}

extension TVSeasonCellViewModelMultipleSection: IdentifiableType {
    var identity: String { return title }
}

extension TVSeasonCellViewModelMultipleSection: Equatable {
    static func == (lhs: TVSeasonCellViewModelMultipleSection, rhs: TVSeasonCellViewModelMultipleSection) -> Bool {
        return lhs.identity == rhs.identity
    }
}

