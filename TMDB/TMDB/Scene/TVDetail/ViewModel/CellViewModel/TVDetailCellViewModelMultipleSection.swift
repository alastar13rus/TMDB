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
    case tvImageListSection(title: String, items: [SectionItem])
    case tvTrailerButtonSection(title: String, items: [SectionItem])
    case tvOverviewSection(title: String, items: [SectionItem])
    case tvRuntimeSection(title: String, items: [SectionItem])
    case tvGenresSection(title: String, items: [SectionItem])
    case tvCreatorsSection(title: String, items: [SectionItem])
    case tvCrewShortListSection(title: String, items: [SectionItem])
    case tvCastShortListSection(title: String, items: [SectionItem])
    case tvSeasonShortListSection(title: String, items: [SectionItem])
    case tvStatusSection(title: String, items: [SectionItem])
    case tvCompilationListSection(title: String, items: [SectionItem])

    enum SectionItem: IdentifiableType, Equatable {
        
        case tvPosterWrapper(vm: TVPosterWrapperCellViewModel)
        case tvImageList(vm: ImageListViewModel)
        case tvTrailerButton(vm: ButtonCellViewModel)
        case tvOverview(vm: MediaOverviewCellViewModel)
        case tvRuntime(vm: TVRuntimeCellViewModel)
        case tvGenres(vm: GenresCellViewModel)
        case tvCrewShortList(vm: CreditShortListViewModel)
        case tvCastShortList(vm: CreditShortListViewModel)
        case tvSeasonShortList(vm: TVSeasonShortListViewModel)
        case tvStatus(vm: MediaStatusCellViewModel)
        case tvCompilationList(vm: MediaCompilationListViewModel)
        
        var identity: String {
            switch self {
            case .tvPosterWrapper(let vm): return vm.id
            case .tvImageList(let vm): return vm.identity
            case .tvTrailerButton(let vm): return vm.identity
            case .tvOverview(let vm): return vm.id
            case .tvRuntime(let vm): return vm.id
            case .tvGenres(let vm): return vm.id
            case .tvCrewShortList(let vm): return vm.creditType.rawValue
            case .tvCastShortList(let vm): return vm.creditType.rawValue
            case .tvSeasonShortList(let vm): return vm.title
            case .tvStatus(let vm): return vm.id
            case .tvCompilationList(let vm): return vm.mediaListType.rawValue
            }
        }
        
        static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
            return lhs.identity == rhs.identity
        }
    }
    
}

extension TVDetailCellViewModelMultipleSection: AnimatableSectionModelType {
    
    var identity: String { return title }
    
    var title: String {
        switch self {
        case .tvPosterWrapperSection(let title, _): return title
        case .tvImageListSection(let title, _): return title
        case .tvTrailerButtonSection(let title, _): return title
        case .tvOverviewSection(let title, _): return title
        case .tvRuntimeSection(let title, _): return title
        case .tvGenresSection(let title, _): return title
        case .tvCreatorsSection(let title, _): return title
        case .tvCrewShortListSection(let title, _): return title
        case .tvCastShortListSection(let title, _): return title
        case .tvSeasonShortListSection(let title, _): return title
        case .tvStatusSection(let title, _): return title
        case .tvCompilationListSection(let title, _): return title
        }
    }
    
    var items: [SectionItem] {
        switch self {
        case .tvPosterWrapperSection(_, let items): return items
        case .tvTrailerButtonSection(_, let items): return items
        case .tvImageListSection(_, let items): return items
        case .tvOverviewSection(_, let items): return items
        case .tvRuntimeSection(_, let items): return items
        case .tvGenresSection(_, let items): return items
        case .tvCreatorsSection(_, let items): return items
        case .tvCrewShortListSection(_, let items): return items
        case .tvCastShortListSection(_, let items): return items
        case .tvSeasonShortListSection(_, let items): return items
        case .tvStatusSection(_, let items): return items
        case .tvCompilationListSection(_, let items): return items
        }
    }
    
    init(original: TVDetailCellViewModelMultipleSection, items: [SectionItem]) {
        switch original {
        case .tvPosterWrapperSection,
             .tvTrailerButtonSection,
             .tvImageListSection,
             .tvOverviewSection,
             .tvRuntimeSection,
             .tvGenresSection,
             .tvCreatorsSection,
             .tvCrewShortListSection,
             .tvCastShortListSection,
             .tvSeasonShortListSection,
             .tvStatusSection,
             .tvCompilationListSection:
            self = original
        }
    }
    
}
