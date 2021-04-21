//
//  MovieDetailCellViewModelMultipleSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.04.2021.
//

import Foundation
import RxRelay
import RxDataSources

enum MovieDetailCellViewModelMultipleSection {
    
    case moviePosterWrapperSection(title: String, items: [SectionItem])
    case movieOverviewSection(title: String, items: [SectionItem])
    case movieRuntimeSection(title: String, items: [SectionItem])
    case movieGenresSection(title: String, items: [SectionItem])
    case movieCreatorsSection(title: String, items: [SectionItem])
    case movieCrewListSection(title: String, items: [SectionItem])
    case movieCastListSection(title: String, items: [SectionItem])
    case movieStatusSection(title: String, items: [SectionItem])

    enum SectionItem: IdentifiableType, Equatable {
        
        case moviePosterWrapper(vm: MoviePosterWrapperCellViewModel)
        case movieOverview(vm: MediaOverviewCellViewModel)
        case movieRuntime(vm: MovieRuntimeCellViewModel)
        case movieGenres(vm: GenresCellViewModel)
        case movieCrewList(vm: CreditShortListViewModel)
        case movieCastList(vm: CreditShortListViewModel)
        case movieStatus(vm: MediaStatusCellViewModel)

        
        var identity: String {
            switch self {
            case .moviePosterWrapper(let vm): return vm.id
            case .movieOverview(let vm): return vm.id
            case .movieRuntime(let vm): return vm.id
            case .movieGenres(let vm): return vm.id
            case .movieCrewList(_): return "crewList"
            case .movieCastList(_): return "castList"
            case .movieStatus(let vm): return vm.id
            }
        }
        
        static func ==(lhs: SectionItem, rhs: SectionItem) -> Bool {
            return lhs.identity == rhs.identity
        }
    }
    
}

extension MovieDetailCellViewModelMultipleSection: AnimatableSectionModelType {
    
    
    typealias Item = SectionItem
    
    var identity: String {
        switch self {
        case .moviePosterWrapperSection(let title, _): return title
        case .movieOverviewSection(let title, _): return title
        case .movieRuntimeSection(let title, _): return title
        case .movieGenresSection(let title, _): return title
        case .movieCreatorsSection(let title, _): return title
        case .movieCrewListSection(let title, _): return title
        case .movieCastListSection(let title, _): return title
        case .movieStatusSection(let title, _): return title

        }
    }
    
    var title: String {
        switch self {
        case .moviePosterWrapperSection(let title, _): return title
        case .movieOverviewSection(let title, _): return title
        case .movieRuntimeSection(let title, _): return title
        case .movieGenresSection(let title, _): return title
        case .movieCreatorsSection(let title, _): return title
        case .movieCrewListSection(let title, _): return title
        case .movieCastListSection(let title, _): return title
        case .movieStatusSection(let title, _): return title
        }
    }
    
    var items: [Item] {
        switch self {
        case .moviePosterWrapperSection(_, let items): return items
        case .movieOverviewSection(_, let items): return items
        case .movieRuntimeSection(_, let items): return items
        case .movieGenresSection(_, let items): return items
        case .movieCreatorsSection(_, let items): return items
        case .movieCrewListSection(_, let items): return items
        case .movieCastListSection(_, let items): return items
        case .movieStatusSection(_, let items): return items
        }
    }
    
    init(original: MovieDetailCellViewModelMultipleSection, items: [Item]) {
        switch original {
        case .moviePosterWrapperSection(_, _): self = original
        case .movieOverviewSection(_, _): self = original
        case .movieRuntimeSection(_, _): self = original
        case .movieGenresSection(_, _): self = original
        case .movieCreatorsSection(_, _): self = original
        case .movieCrewListSection(_, _): self = original
        case .movieCastListSection(_, _): self = original
        case .movieStatusSection(_, _): self = original
        }
    }
    
    
}
