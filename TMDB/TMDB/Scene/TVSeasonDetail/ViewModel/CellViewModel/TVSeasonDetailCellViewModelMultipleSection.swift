//
//  TVSeasonDetailCellViewModelMultipleSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 04.05.2021.
//

import Foundation
import RxRelay
import RxDataSources

enum TVSeasonDetailCellViewModelMultipleSection {
    
    case tvSeasonPosterWrapperSection(title: String, items: [SectionItem])
    case tvSeasonImageListSection(title: String, items: [SectionItem])
    case tvSeasonTrailerButtonSection(title: String, items: [SectionItem])
    case tvSeasonOverviewSection(title: String, items: [SectionItem])
    case tvEpisodeShortListSection(title: String, items: [SectionItem])
    case tvSeasonCastShortListSection(title: String, items: [SectionItem])
    case tvSeasonCrewShortListSection(title: String, items: [SectionItem])

    enum SectionItem: IdentifiableType, Equatable {
        
        case tvSeasonPosterWrapper(vm: TVSeasonPosterWrapperCellViewModel)
        case tvSeasonImageList(vm: ImageListViewModel)
        case tvSeasonTrailerButton(vm: ButtonCellViewModel)
        case tvSeasonOverview(vm: TVSeasonOverviewCellViewModel)
        case tvEpisodeShortList(vm: TVEpisodeShortListViewModel)
        case tvSeasonCrewShortList(vm: CreditShortListViewModel)
        case tvSeasonCastShortList(vm: CreditShortListViewModel)
        
        var identity: String {
            switch self {
            case .tvSeasonPosterWrapper(let vm): return vm.id
            case .tvSeasonImageList(let vm): return vm.identity
            case .tvSeasonTrailerButton(let vm): return vm.identity
            case .tvSeasonOverview(let vm): return vm.id
            case .tvEpisodeShortList(let vm): return vm.title
            case .tvSeasonCrewShortList(let vm): return vm.creditType.rawValue
            case .tvSeasonCastShortList(let vm): return vm.creditType.rawValue
            }
        }
        
        static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
            return lhs.identity == rhs.identity
        }
    }
    
}

extension TVSeasonDetailCellViewModelMultipleSection: AnimatableSectionModelType {
    
    var identity: String { return title }
    
    var title: String {
        switch self {
        case .tvSeasonPosterWrapperSection(let title, _): return title
        case .tvSeasonImageListSection(let title, _): return title
        case .tvSeasonTrailerButtonSection(let title, _): return title
        case .tvSeasonOverviewSection(let title, _): return title
        case .tvEpisodeShortListSection(let title, _): return title
        case .tvSeasonCrewShortListSection(let title, _): return title
        case .tvSeasonCastShortListSection(let title, _): return title
        }
    }
    
    var items: [SectionItem] {
        switch self {
        case .tvSeasonPosterWrapperSection(_, let items): return items
        case .tvSeasonTrailerButtonSection(_, let items): return items
        case .tvSeasonImageListSection(_, let items): return items
        case .tvSeasonOverviewSection(_, let items): return items
        case .tvEpisodeShortListSection(_, let items): return items
        case .tvSeasonCrewShortListSection(_, let items): return items
        case .tvSeasonCastShortListSection(_, let items): return items
        }
    }
    
    init(original: TVSeasonDetailCellViewModelMultipleSection, items: [SectionItem]) {
        switch original {
        case .tvSeasonPosterWrapperSection,
             .tvSeasonTrailerButtonSection,
             .tvSeasonImageListSection,
             .tvSeasonOverviewSection,
             .tvEpisodeShortListSection,
             .tvSeasonCrewShortListSection,
             .tvSeasonCastShortListSection:
            self = original
        }
    }
    
}
