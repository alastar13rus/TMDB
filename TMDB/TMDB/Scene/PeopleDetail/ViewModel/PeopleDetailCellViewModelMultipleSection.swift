//
//  PeopleDetailCellViewModelMultipleSection.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.04.2021.
//

import Foundation
import RxDataSources

enum PeopleDetailCellViewModelMultipleSection {
    case profileWrapperSection(title: String, items: [SectionItem])
    case imageListSection(title: String, items: [SectionItem])
    case bioSection(title: String, items: [SectionItem])
    case bestMediaSection(title: String, items: [SectionItem])
    case castSection(title: String, items: [SectionItem])
    case crewSection(title: String, items: [SectionItem])

    enum SectionItem: IdentifiableType, Equatable {
        case profileWrapper(vm: PeopleProfileWrapperCellViewModel)
        case imageList(vm: PeopleImageListViewModel)
        case bio(vm: PeopleBioCellViewModel)
        case bestMedia(vm: PeopleBestMediaListViewModel<PeopleDetailViewModel>)
        case cast(vm: CreditInMediaViewModel)
        case crew(vm: CreditInMediaViewModel)
        
        var identity: String {
            switch self {
            case .profileWrapper(let vm): return vm.id
            case .imageList(let vm): return vm.identity
            case .bio(let vm): return vm.id
            case .bestMedia(let vm): return vm.identity
            case .cast(let vm): return vm.id
            case .crew(let vm): return vm.id
            }
        }
        
        var isEmpty: Bool {
            switch self {
            case .bio(let vm):
                return vm.bio.isEmpty
            default:
                return false
            }
        }
        
        static func ==(lhs: SectionItem, rhs: SectionItem) -> Bool {
            switch (lhs, rhs) {
            case (.profileWrapper(_), .profileWrapper(_)):
                return lhs.identity == rhs.identity
            case (.imageList(_), .imageList(_)):
                return lhs.identity == rhs.identity
            case (.bio(_), .bio(_)):
                return lhs.identity == rhs.identity
            case (.bestMedia(_), .bestMedia(_)):
                return lhs.identity == rhs.identity
            case (.cast(_), .cast(_)):
                return lhs.identity == rhs.identity
            case (.crew(_), .crew(_)):
                return lhs.identity == rhs.identity
            default: return false
            }
        }
    }
}

//  MARK: - Extensions
extension PeopleDetailCellViewModelMultipleSection: AnimatableSectionModelType {
    
    var title: String {
        switch self {
        case .profileWrapperSection(let title, _): return title
        case .imageListSection(let title, _): return title
        case .bioSection(let title, _): return title
        case .bestMediaSection(let title, _): return title
        case .castSection(let title, _): return title
        case .crewSection(let title, _): return title
        }
    }
    
    var items: [SectionItem] {
        switch self {
        case .profileWrapperSection(_, let items): return items
        case .imageListSection(_, let items): return items
        case .bioSection(_, let items): return items
        case .bestMediaSection(_, let items): return items
        case .castSection(_, let items): return items
        case .crewSection(_, let items): return items
        }
    }
    
    var isEmpty: Bool {
        switch self {
        case .bioSection(_, let items):
            return items.filter { !$0.isEmpty }.count == 0
        default:
            return false
        }
    }
    
    init(original: PeopleDetailCellViewModelMultipleSection, items: [SectionItem]) {
        switch original {
        case .profileWrapperSection(let title, _):
            self = .profileWrapperSection(title: title, items: items)
        case .imageListSection(let title, _):
            self = .imageListSection(title: title, items: items)
        case .bioSection(let title, _):
            self = .bioSection(title: title, items: items)
        case .bestMediaSection(let title, _):
            self = .bestMediaSection(title: title, items: items)
        case .castSection(let title, _):
            self = .castSection(title: title, items: items)
        case .crewSection(let title, _):
            self = .crewSection(title: title, items: items)
        }
    }
    
    
    
}

extension PeopleDetailCellViewModelMultipleSection: IdentifiableType {
    var identity: String { return title }
}

extension PeopleDetailCellViewModelMultipleSection: Equatable {
    static func ==(lhs: PeopleDetailCellViewModelMultipleSection, rhs: PeopleDetailCellViewModelMultipleSection) -> Bool {
        return lhs.identity == rhs.identity
    }
}
