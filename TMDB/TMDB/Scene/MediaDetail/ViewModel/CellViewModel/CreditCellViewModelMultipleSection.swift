//
//  CreditCellViewModelMultipleSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.04.2021.
//

import Foundation
import RxDataSources

enum CreditCellViewModelMultipleSection {
    
    case castSection(title: String, items: [SectionItem])
    case crewSection(title: String, items: [SectionItem])
    case showMoreSection(title: String, items: [SectionItem])
    
    enum SectionItem: IdentifiableType, Equatable {
        case cast(vm: CastCellViewModel)
        case crew(vm: CrewCellViewModel)
        case showMore(vm: ShowMoreCellViewModel)
        
        var identity: String {
            switch self {
            case .cast(let vm): return "\(vm.id)"
            case .crew(let vm): return "\(vm.id)"
            case .showMore(let vm): return vm.title
            }
        }
        
        static func ==(lhs: SectionItem, rhs: SectionItem) -> Bool {
            switch (lhs, rhs) {
            case (.cast(_), .crew(_)), (.crew(_), .cast(_)): return false
            case (.cast(_), .showMore(_)), (.showMore(_), .cast(_)): return false
            case (.crew(_), .showMore(_)), (.showMore(_), .crew(_)): return false
            case (.cast(let lhsVM), .cast(let rhsVM)): return lhsVM == rhsVM
            case (.crew(let lhsVM), .crew(let rhsVM)): return lhsVM == rhsVM
            case (.showMore(let lhsVM), .showMore(let rhsVM)): return lhsVM == rhsVM
            }
        }
    }
}

//MARK: Extensions

extension CreditCellViewModelMultipleSection: AnimatableSectionModelType {
    
    var title: String {
        switch self {
        case .castSection(let title, _): return title
        case .crewSection(let title, _): return title
        case .showMoreSection(let title, _): return title
        }
    }
    
    var items: [SectionItem] {
        switch self {
        case .castSection(_, let items): return items
        case .crewSection(_, let items): return items
        case .showMoreSection(_, let items): return items
        }
    }
    
    init(original: CreditCellViewModelMultipleSection, items: [SectionItem]) {
        switch original {
        case .castSection(_, _): self = original
        case .crewSection(_, _): self = original
        case .showMoreSection(_, _): self = original
        }
    }
}

extension CreditCellViewModelMultipleSection: IdentifiableType {
    var identity: String { return title }
}

extension CreditCellViewModelMultipleSection: Equatable {
    static func ==(lhs: CreditCellViewModelMultipleSection, rhs: CreditCellViewModelMultipleSection) -> Bool {
        return lhs.items == rhs.items && lhs.identity == rhs.identity
    }
}
