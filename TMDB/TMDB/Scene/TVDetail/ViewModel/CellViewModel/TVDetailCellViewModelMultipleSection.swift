//
//  TVDetailCellViewModelMultipleSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 09.04.2021.
//

import Foundation
import RxRelay
import RxDataSources

enum TVDetailCellViewModelMultipleSection {
    
    case tvPosterWrapperSection(title: String, items: [SectionItem])
    case tvOverviewSection(title: String, items: [SectionItem])
    case tvRuntimeSection(title: String, items: [SectionItem])
    case tvGenresSection(title: String, items: [SectionItem])
    case tvCreatorsSection(title: String, items: [SectionItem])
    case tvCastListSection(title: String, items: [SectionItem])
    case tvStatusSection(title: String, items: [SectionItem])

    enum SectionItem: IdentifiableType, Equatable {
        
        case tvPosterWrapper(vm: TVPosterWrapperCellViewModel)
        case tvOverview(vm: MediaOverviewCellViewModel)
        case tvRuntime(vm: TVRuntimeCellViewModel)
        case tvGenres(vm: GenresCellViewModel)
        case tvCreators(vm: CreatorWithPhotoCellViewModel)
        case tvCastList(vm: CastListViewModel)
        case tvStatus(vm: MediaStatusCellViewModel)


        var identity: String {
            switch self {
            case .tvPosterWrapper(let vm): return vm.id
            case .tvOverview(let vm): return vm.id
            case .tvRuntime(let vm): return vm.id
            case .tvGenres(let vm): return vm.id
            case .tvCreators(let vm): return vm.id
            case .tvCastList(_): return "castList"
            case .tvStatus(let vm): return vm.id
            }
        }
        
        static func ==(lhs: SectionItem, rhs: SectionItem) -> Bool {
            return lhs.identity == rhs.identity
        }
    }
    
}

extension TVDetailCellViewModelMultipleSection: AnimatableSectionModelType {
    
    
    typealias Item = SectionItem
    
    var identity: String {
        switch self {
        case .tvPosterWrapperSection(let title, _): return title
        case .tvOverviewSection(let title, _): return title
        case .tvRuntimeSection(let title, _): return title
        case .tvGenresSection(let title, _): return title
        case .tvCreatorsSection(let title, _): return title
        case .tvCastListSection(let title, _): return title
        case .tvStatusSection(let title, _): return title

        }
    }
    
    var title: String {
        switch self {
        case .tvPosterWrapperSection(let title, _): return title
        case .tvOverviewSection(let title, _): return title
        case .tvRuntimeSection(let title, _): return title
        case .tvGenresSection(let title, _): return title
        case .tvCreatorsSection(let title, _): return title
        case .tvCastListSection(let title, _): return title
        case .tvStatusSection(let title, _): return title
        }
    }
    
    var items: [Item] {
        switch self {
        case .tvPosterWrapperSection(_, let items): return items
        case .tvOverviewSection(_, let items): return items
        case .tvRuntimeSection(_, let items): return items
        case .tvGenresSection(_, let items): return items
        case .tvCreatorsSection(_, let items): return items
        case .tvCastListSection(_, let items): return items
        case .tvStatusSection(_, let items): return items
        }
    }
    
    init(original: TVDetailCellViewModelMultipleSection, items: [Item]) {
        switch original {
        case .tvPosterWrapperSection(_, _): self = original
        case .tvOverviewSection(_, _): self = original
        case .tvRuntimeSection(_, _): self = original
        case .tvGenresSection(_, _): self = original
        case .tvCreatorsSection(_, _): self = original
        case .tvCastListSection(_, _): self = original
        case .tvStatusSection(_, _): self = original
        }
    }
    
    
}
