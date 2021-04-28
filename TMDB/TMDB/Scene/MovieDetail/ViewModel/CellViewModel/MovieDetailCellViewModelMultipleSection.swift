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
    case movieImageListSection(title: String, items: [SectionItem])
    case movieOverviewSection(title: String, items: [SectionItem])
    case movieRuntimeSection(title: String, items: [SectionItem])
    case movieGenresSection(title: String, items: [SectionItem])
    case movieCreatorsSection(title: String, items: [SectionItem])
    case movieCrewListSection(title: String, items: [SectionItem])
    case movieCastListSection(title: String, items: [SectionItem])
    case movieStatusSection(title: String, items: [SectionItem])
    case movieCompilationListSection(title: String, items: [SectionItem])

    enum SectionItem: IdentifiableType, Equatable {
        
        case moviePosterWrapper(vm: MoviePosterWrapperCellViewModel)
        case movieImageList(vm: ImageListViewModel)
        case movieOverview(vm: MediaOverviewCellViewModel)
        case movieRuntime(vm: MovieRuntimeCellViewModel)
        case movieGenres(vm: GenresCellViewModel)
        case movieCrewList(vm: CreditShortListViewModel)
        case movieCastList(vm: CreditShortListViewModel)
        case movieStatus(vm: MediaStatusCellViewModel)
        case movieCompilationList(vm: MediaCompilationListViewModel)

        
        var identity: String {
            switch self {
            case .moviePosterWrapper(let vm): return vm.id
            case .movieImageList(let vm): return vm.identity
            case .movieOverview(let vm): return vm.id
            case .movieRuntime(let vm): return vm.id
            case .movieGenres(let vm): return vm.id
            case .movieCrewList(let vm): return vm.creditType.rawValue
            case .movieCastList(let vm): return vm.creditType.rawValue
            case .movieStatus(let vm): return vm.id
            case .movieCompilationList(let vm): return vm.mediaListType.rawValue
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
        case .movieImageListSection(let title, _): return title
        case .movieOverviewSection(let title, _): return title
        case .movieRuntimeSection(let title, _): return title
        case .movieGenresSection(let title, _): return title
        case .movieCreatorsSection(let title, _): return title
        case .movieCrewListSection(let title, _): return title
        case .movieCastListSection(let title, _): return title
        case .movieStatusSection(let title, _): return title
        case .movieCompilationListSection(let title, _): return title

        }
    }
    
    var title: String {
        switch self {
        case .moviePosterWrapperSection(let title, _): return title
        case .movieImageListSection(let title, _): return title
        case .movieOverviewSection(let title, _): return title
        case .movieRuntimeSection(let title, _): return title
        case .movieGenresSection(let title, _): return title
        case .movieCreatorsSection(let title, _): return title
        case .movieCrewListSection(let title, _): return title
        case .movieCastListSection(let title, _): return title
        case .movieStatusSection(let title, _): return title
        case .movieCompilationListSection(let title, _): return title
        }
    }
    
    var items: [Item] {
        switch self {
        case .moviePosterWrapperSection(_, let items): return items
        case .movieImageListSection(_, let items): return items
        case .movieOverviewSection(_, let items): return items
        case .movieRuntimeSection(_, let items): return items
        case .movieGenresSection(_, let items): return items
        case .movieCreatorsSection(_, let items): return items
        case .movieCrewListSection(_, let items): return items
        case .movieCastListSection(_, let items): return items
        case .movieStatusSection(_, let items): return items
        case .movieCompilationListSection(_, let items): return items
        }
    }
    
    init(original: MovieDetailCellViewModelMultipleSection, items: [Item]) {
        switch original {
        case .moviePosterWrapperSection: self = original
        case .movieImageListSection: self = original
        case .movieOverviewSection: self = original
        case .movieRuntimeSection: self = original
        case .movieGenresSection: self = original
        case .movieCreatorsSection: self = original
        case .movieCrewListSection: self = original
        case .movieCastListSection: self = original
        case .movieStatusSection: self = original
        case .movieCompilationListSection: self = original
        }
    }
    
    
}
