//
//  CreditListViewModelMultipleSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 15.04.2021.
//

import Foundation
import RxDataSources

enum CreditListViewModelMultipleSection {
    
    case castSection(title: String, items: [SectionItem])
    case crewSection(title: String, items: [SectionItem])
    
    enum SectionItem: IdentifiableType, Equatable {
        case cast(vm: CastCellViewModel)
        case crew(vm: CrewCombinedCellViewModel)
        
        var identity: String {
            switch self {
            case .cast(let vm): return "\(vm.id)"
            case .crew(let vm): return "\(vm.id)"
            }
        }
        
        static func ==(lhs: SectionItem, rhs: SectionItem) -> Bool {
            return lhs.identity == rhs.identity
        }
        
    }
    
}

extension CreditListViewModelMultipleSection: AnimatableSectionModelType, IdentifiableType {
    
    var identity: String {
        switch self {
        case .castSection(let title, _): return title
        case .crewSection(let title, _): return title
        }
    }
    
    var items: [SectionItem] {
        switch self {
        case .castSection(_, let items): return items
        case .crewSection(_, let items): return items
        }
    }
    
    init(original: CreditListViewModelMultipleSection, items: [SectionItem]) {
        switch original {
        case .castSection(let title, _):
            self = .castSection(title: title, items: items)
        case .crewSection(let title, _):
            self = .crewSection(title: title, items: items)
        }
    }
    
}
