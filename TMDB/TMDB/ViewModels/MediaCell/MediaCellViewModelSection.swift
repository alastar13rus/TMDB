//
//  MediaCellViewModelSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 17.03.2021.
//

import Foundation
import RxDataSources

enum MediaCellViewModelMultipleSection {
    
    case movieSection(title: String, items: [SectionItem])
    case tvSection(title: String, items: [SectionItem])

    enum SectionItem: IdentifiableType, Equatable {
        case movie(vm: MediaCellViewModel)
        case tv(vm: MediaCellViewModel)
        
        var identity: String {
            switch self {
            case .movie(let vm): return "\(vm.id)_\(vm.title)"
            case .tv(let vm): return "\(vm.id)_\(vm.title)"
            }
        }
        
        static func ==(lhs: SectionItem, rhs: SectionItem) -> Bool {
            return lhs.identity == rhs.identity
        }
        
    }
    
}

extension MediaCellViewModelMultipleSection: AnimatableSectionModelType, Equatable {
    
    typealias Item = SectionItem
    
    var title: String {
        switch self {
        case .movieSection(let title, _): return title
        case .tvSection(let title, _): return title
        }
    }
    
    var items: [Item] {
        switch self {
        case .movieSection(_, let items): return items.map { $0 }
        case .tvSection(_, let items): return items.map { $0 }
        }
    }
    
    init(original: MediaCellViewModelMultipleSection, items: [SectionItem]) {
        switch original {
        case .movieSection(let title, _):
            self = .movieSection(title: title, items: items)
        case .tvSection(let title, _):
            self = .tvSection(title: title, items: items)
        }
    }
    
}

extension MediaCellViewModelMultipleSection: IdentifiableType {
    var identity: String {
        switch self {
        case .movieSection(let title, _):
            return title
        case .tvSection(let title, _):
            return title
        }
    }
}
