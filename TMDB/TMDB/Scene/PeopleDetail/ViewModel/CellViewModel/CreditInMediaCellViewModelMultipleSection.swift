//
//  CreditInMediaCellViewModelMultipleSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 19.04.2021.
//

import Foundation
import RxDataSources

enum CreditInMediaCellViewModelMultipleSection {
    case creditInMovieSection(title: String, items: [SectionItem])
    case creditInTVSection(title: String, items: [SectionItem])
    
    enum SectionItem: IdentifiableType, Equatable, Comparable {
        
        case creditInMovie(vm: CreditInMediaViewModel)
        case creditInTV(vm: CreditInMediaViewModel)
        
        var identity: String {
            switch self {
            case .creditInMovie(let vm): return "\(vm.id)"
            case .creditInTV(let vm): return "\(vm.id)"
            }
        }
        
        static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
            return lhs.identity == rhs.identity
        }
        
        static func < (lhs: SectionItem, rhs: SectionItem) -> Bool {
            switch (lhs, rhs) {
            case (.creditInMovie(let lhsVM), .creditInTV(let rhsVM)):
                return lhsVM.voteAverage < rhsVM.voteAverage
            case (.creditInTV(let lhsVM), .creditInMovie(let rhsVM)):
                return lhsVM.voteAverage < rhsVM.voteAverage
            case (.creditInMovie(let lhsVM), .creditInMovie(let rhsVM)):
                return lhsVM.voteAverage < rhsVM.voteAverage
            case (.creditInTV(let lhsVM), .creditInTV(let rhsVM)):
                return lhsVM.voteAverage < rhsVM.voteAverage
            }
        }
        
    }
}

extension CreditInMediaCellViewModelMultipleSection: AnimatableSectionModelType {
    
    var title: String {
        switch self {
        case .creditInMovieSection(let title, _): return title
        case .creditInTVSection(let title, _): return title
        }
    }
    
    var items: [SectionItem] {
        switch self {
        case .creditInMovieSection(_, let items): return items
        case .creditInTVSection(_, let items): return items
        }
    }
    
    init(original: CreditInMediaCellViewModelMultipleSection, items: [SectionItem]) {
        switch original {
        case .creditInMovieSection(let title, _):
            self = .creditInMovieSection(title: title, items: items)
        case .creditInTVSection(let title, _):
            self = .creditInTVSection(title: title, items: items)
        }
    }
    
}

extension CreditInMediaCellViewModelMultipleSection: IdentifiableType {
    var identity: String { return title }
}

extension CreditInMediaCellViewModelMultipleSection: Equatable {
    
}
