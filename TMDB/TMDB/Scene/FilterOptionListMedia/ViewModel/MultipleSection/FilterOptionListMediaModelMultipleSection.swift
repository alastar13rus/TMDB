//
//  FilterOptionListMediaModelMultipleSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.05.2021.
//

import Foundation
import RxDataSources

enum FilterOptionListMediaModelMultipleSection {
    
    case mediaByYearSection(title: String, items: [SectionItem])
    case mediaWithGenreSection(title: String, items: [SectionItem])
    
    enum SectionItem: IdentifiableType, Equatable {
        case mediaByYear(vm: FilterOptionMediaByYearCellViewModel)
        case mediaByGenre(vm: FilterOptionMediaByGenreCellViewModel)
        
        var identity: String {
            switch self {
            case .mediaByYear(let vm): return vm.identity
            case .mediaByGenre(let vm): return vm.identity
            }
        }
        
        static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
            switch (lhs, rhs) {
            case (.mediaByYear(let lhsVM), .mediaByYear(let rhsVM)):
                return lhsVM.identity == rhsVM.identity
            case (.mediaByGenre(let lhsVM), .mediaByGenre(let rhsVM)):
                return lhsVM.identity == rhsVM.identity
            default: return false
            }
        }
        
    }
    
}

extension FilterOptionListMediaModelMultipleSection: AnimatableSectionModelType {
    
    var title: String {
        switch self {
        case .mediaByYearSection(let title, _): return title
        case .mediaWithGenreSection(let title, _): return title
        }
    }
    
    var items: [SectionItem] {
        switch self {
        case .mediaByYearSection(_, let items): return items
        case .mediaWithGenreSection(_, let items): return items
        }
    }
    
    init(original: FilterOptionListMediaModelMultipleSection, items: [SectionItem]) {
        switch original {
        case .mediaByYearSection(let title, _): self = .mediaByYearSection(title: title, items: items)
        case .mediaWithGenreSection(let title, _): self = .mediaWithGenreSection(title: title, items: items)
        }
    }
}

extension FilterOptionListMediaModelMultipleSection: IdentifiableType {
    var identity: String { title }
}
