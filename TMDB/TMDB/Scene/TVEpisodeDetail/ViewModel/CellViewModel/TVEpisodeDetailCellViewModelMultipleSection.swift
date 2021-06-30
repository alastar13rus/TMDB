//
//  TVEpisodeDetailCellViewModelMultipleSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.05.2021.
//

import Foundation
import RxRelay
import RxDataSources

enum TVEpisodeDetailCellViewModelMultipleSection {
    
    case tvEpisodeStillWrapperSection(title: String, items: [SectionItem])
    case tvEpisodeImageListSection(title: String, items: [SectionItem])
    case tvEpisodeTrailerButtonSection(title: String, items: [SectionItem])
    case tvEpisodeOverviewSection(title: String, items: [SectionItem])
    case tvEpisodeCastShortListSection(title: String, items: [SectionItem])
    case tvEpisodeCrewShortListSection(title: String, items: [SectionItem])
    case tvEpisodeGuestStarsShortListSection(title: String, items: [SectionItem])

    enum SectionItem: IdentifiableType, Equatable {
        
        case tvEpisodeStillWrapper(vm: TVEpisodeStillWrapperCellViewModel)
        case tvEpisodeImageList(vm: ImageListViewModel)
        case tvEpisodeTrailerButton(vm: ButtonCellViewModel)
        case tvEpisodeOverview(vm: TVEpisodeOverviewCellViewModel)
        case tvEpisodeCrewShortList(vm: CreditShortListViewModel)
        case tvEpisodeCastShortList(vm: CreditShortListViewModel)
        case tvEpisodeGuestStarsShortList(vm: CreditShortListViewModel)
        
        var identity: String {
            switch self {
            case .tvEpisodeStillWrapper(let vm): return vm.id
            case .tvEpisodeImageList(let vm): return vm.identity
            case .tvEpisodeTrailerButton(let vm): return vm.identity
            case .tvEpisodeOverview(let vm): return vm.id
            case .tvEpisodeCrewShortList(let vm): return vm.creditType.rawValue
            case .tvEpisodeCastShortList(let vm): return vm.creditType.rawValue
            case .tvEpisodeGuestStarsShortList(let vm): return vm.creditType.rawValue
            }
        }
        
        static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
            return lhs.identity == rhs.identity
        }
    }
    
}

extension TVEpisodeDetailCellViewModelMultipleSection: AnimatableSectionModelType {
    
    var identity: String { return title }
    
    var title: String {
        switch self {
        case .tvEpisodeStillWrapperSection(let title, _): return title
        case .tvEpisodeImageListSection(let title, _): return title
        case .tvEpisodeTrailerButtonSection(let title, _): return title
        case .tvEpisodeOverviewSection(let title, _): return title
        case .tvEpisodeCrewShortListSection(let title, _): return title
        case .tvEpisodeCastShortListSection(let title, _): return title
        case .tvEpisodeGuestStarsShortListSection(let title, _): return title
        }
    }
    
    var items: [SectionItem] {
        switch self {
        case .tvEpisodeStillWrapperSection(_, let items): return items
        case .tvEpisodeTrailerButtonSection(_, let items): return items
        case .tvEpisodeImageListSection(_, let items): return items
        case .tvEpisodeOverviewSection(_, let items): return items
        case .tvEpisodeCrewShortListSection(_, let items): return items
        case .tvEpisodeCastShortListSection(_, let items): return items
        case .tvEpisodeGuestStarsShortListSection(_, let items): return items
        }
    }
    
    init(original: TVEpisodeDetailCellViewModelMultipleSection, items: [SectionItem]) {
        switch original {
        case .tvEpisodeStillWrapperSection,
             .tvEpisodeTrailerButtonSection,
             .tvEpisodeImageListSection,
             .tvEpisodeOverviewSection,
             .tvEpisodeCrewShortListSection,
             .tvEpisodeCastShortListSection,
             .tvEpisodeGuestStarsShortListSection:
            self = original
        }
    }
    
}
