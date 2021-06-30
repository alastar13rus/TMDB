//
//  TVEpisodeCellViewModelMultipleSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 05.05.2021.
//

import Foundation
import RxDataSources

enum TVEpisodeCellViewModelMultipleSection {
    
    case episodeSection(title: String, items: [SectionItem])
    case showMoreSection(title: String, items: [SectionItem])
    
    enum SectionItem: IdentifiableType, Equatable {
        case episode(vm: TVEpisodeCellViewModel)
        case showMore(vm: ShowMoreCellViewModel)
        
        var identity: String {
            switch self {
            case .episode(let vm): return vm.id
            case .showMore(let vm): return vm.type.rawValue
            }
        }
    }
    
    init(original: TVEpisodeCellViewModelMultipleSection, items: [SectionItem]) {
        switch original {
        case .episodeSection(let title, _):
            self = .episodeSection(title: title, items: items)
        case .showMoreSection(let title, _):
            self = .showMoreSection(title: title, items: items)
        }
    }
}

extension TVEpisodeCellViewModelMultipleSection: AnimatableSectionModelType {
    
    var title: String {
        switch self {
        case .episodeSection(let title, _): return title
        case .showMoreSection(let title, _): return title
        }
    }
    
    var items: [SectionItem] {
        switch self {
        case .episodeSection(_, let items): return items
        case .showMoreSection(_, let items): return items
        }
    }
}

extension TVEpisodeCellViewModelMultipleSection: IdentifiableType {
    var identity: String { return title }
}

extension TVEpisodeCellViewModelMultipleSection: Equatable {
    static func == (lhs: TVEpisodeCellViewModelMultipleSection, rhs: TVEpisodeCellViewModelMultipleSection) -> Bool {
        return lhs.identity == rhs.identity
    }
}
