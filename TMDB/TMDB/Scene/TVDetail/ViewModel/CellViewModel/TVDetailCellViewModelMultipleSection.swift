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
    case tvCastListSection(title: String, items: [SectionItem])
    case tvCrewListSection(title: String, items: [SectionItem])
    case tvStatusSection(title: String, items: [SectionItem])
    case tvRecommendationListSection(title: String, items: [SectionItem])

    enum SectionItem: IdentifiableType, Equatable {
        
        case tvPosterWrapper(vm: TVPosterWrapperCellViewModel)
        case tvOverview(vm: MediaOverviewCellViewModel)
        case tvRuntime(vm: TVRuntimeCellViewModel)
        case tvGenres(vm: GenresCellViewModel)
        case tvCastList(vm: CreditShortListViewModel)
        case tvCrewList(vm: CreditShortListViewModel)
        case tvStatus(vm: MediaStatusCellViewModel)
        case tvRecommendationList(vm: MediaRecommendationListViewModel)


        var identity: String {
            switch self {
            case .tvPosterWrapper(let vm): return vm.id
            case .tvOverview(let vm): return vm.id
            case .tvRuntime(let vm): return vm.id
            case .tvGenres(let vm): return vm.id
            case .tvCastList: return "castList"
            case .tvCrewList: return "crewList"
            case .tvStatus(let vm): return vm.id
            case .tvRecommendationList: return "recommendationList"
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
        case .tvCastListSection(let title, _): return title
        case .tvCrewListSection(let title, _): return title
        case .tvStatusSection(let title, _): return title
        case .tvRecommendationListSection(let title, _): return title
        }
    }
    
    var title: String {
        switch self {
        case .tvPosterWrapperSection(let title, _): return title
        case .tvOverviewSection(let title, _): return title
        case .tvRuntimeSection(let title, _): return title
        case .tvGenresSection(let title, _): return title
        case .tvCastListSection(let title, _): return title
        case .tvCrewListSection(let title, _): return title
        case .tvStatusSection(let title, _): return title
        case .tvRecommendationListSection(let title, _): return title
        }
    }
    
    var items: [Item] {
        switch self {
        case .tvPosterWrapperSection(_, let items): return items
        case .tvOverviewSection(_, let items): return items
        case .tvRuntimeSection(_, let items): return items
        case .tvGenresSection(_, let items): return items
        case .tvCastListSection(_, let items): return items
        case .tvCrewListSection(_, let items): return items
        case .tvStatusSection(_, let items): return items
        case .tvRecommendationListSection(_, let items): return items
        }
    }
    
    init(original: TVDetailCellViewModelMultipleSection, items: [Item]) {
        switch original {
        case .tvPosterWrapperSection: self = original
        case .tvOverviewSection: self = original
        case .tvRuntimeSection: self = original
        case .tvGenresSection: self = original
        case .tvCastListSection: self = original
        case .tvCrewListSection: self = original
        case .tvStatusSection: self = original
        case .tvRecommendationListSection: self = original
        }
    }
    
    
}
